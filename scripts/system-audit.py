#!/usr/bin/env python
"""
This is an audit tool that can be automated and set to notify if a setting
violates those settings as specified in the given compliance document in YAML.
It can also be done used to produce a report of a system as a security measure.
"""

import yaml
import types
import subprocess
import argparse

__author__ = 'Juan Segovia'
__version__ = '1.3'

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


class Benchmark:
    def __init__(self, file_path='none'):
        """Constructor for the Benchmark Class. This ensures that a benchmark object is created.

        """
        self.data = {}
        self.outputDict = {}
        self.curKey = ''
        if file_path is not 'none':
            self.__load_file(file_path)
            self.topKey = self.data.keys()[0]
        else:
            file_error = "Unable to load data into benchmark object. Likely the yml file can't be loaded"
            raise NameError(file_error)
            # sys.exit(1)

    def __load_file(self, file_path):
        """Load the CIS-benchmark file.yml

        Keyword argumesnt:
        filePath - string consisting of path to a file containing the data to use for the audit.

        Returns:
        nothing but fills self.data
        """
        with open(file_path) as f:
            self.data = yaml.load(f)

    def _get_keys(self):
        return self.data.keys()

    def _get_sections(self):
        """returns they keys for the layer.

        """
        sections = self.data[self.topKey].keys()
        sections.sort()
        return sections

    def _get_data(self):
        return self.data

    def collect_data(self, section='none'):
        """method used to kick off the data collection on a system.

        """
        if section == 'none':
            sections = self._get_sections()
            for section in sections:
                self.collect_data(section)
        else:
            # Let's run the audit and update results so we have something to print.
            section_dict = self.data[self.topKey][section]
            self.data[self.topKey][section] = self.__process_section_items(section_dict)
            self.__populate_output(section_dict)

    def print_verbose(self, section='none'):
        """print the result of the audit including the commands and outputs...

        """
        if section == 'none':
            sections = self._get_sections()
            for section in sections:
                print "{0:*^100}".format(section)
                self.print_verbose(section)
        else:
            # Let's print what we have.
            section_dict = self.data[self.topKey][section]
            self.__print_section_items(section_dict)

    @staticmethod
    def __run_command(command):
        """Executes a command to be used for evaluation.

        """
        output = []
        return_code = 0
        try:
            p = subprocess.Popen(command,
                                 shell=True,
                                 stdout=subprocess.PIPE,
                                 stderr=subprocess.STDOUT,
                                 universal_newlines=True)
            output = p.communicate()
            return_code = p.poll()
        except subprocess.CalledProcessError, error:
            print "subprocess CalledProcessError.output = " + error.output

        return output, return_code

    def __exec_audit(self, audit_list, expected_list):
        """this method evaluates the result of each command then determines if it's a pass or fail.

        """
        result = ''
        output = []
        for cmd in audit_list:
            if cmd == 'skip':
                result = 'skip'
                output = ('skipped', '')
                return result, tuple(output)
            else:
                std_out, return_code = self.__run_command(cmd)
                output.extend(list(std_out))

                if return_code == expected_list[audit_list.index(cmd)]:
                    result = 'pass'
                else:
                    result = 'fail'

                # Run the command and record the output and return code.
                if result != 'fail':
                    result = 'pass'
                else:
                    result = 'fail'
                    break
        return result, tuple(output)

    def __process_section_items(self, section):
        """this method is used to run the audit commands and update the data dict with the results.

        """
        if isinstance(section, types.DictionaryType):
            for key, value in section.items():
                if key == 'audit':
                    # Pass the list of commands (value, as well as the expected results)
                    # NOTE: the lists must be ordered in with the same index locations.
                    cmd_list = value
                    expected_list = section['expected']
                    values = self.__exec_audit(cmd_list, expected_list)
                    result, output = values[0], values[1]

                    # We got a pass or fail, let's update the dict we're working on.
                    section['result'] = result
                    section['output'] = output

                if isinstance(section, types.DictionaryType):
                    # we've probably updated the result key a few times...
                    # Let's pass that back to upstream.
                    section[key] = self.__process_section_items(value)

        # Let's return the updated dictionary.
        return section

    def __print_section_items(self, section):
        if isinstance(section, types.DictionaryType):
            for key, value in sorted(section.items(), key=self.__sort_key):
                if key == 'audit':
                    cmd = value
                    result = section['result']
                    output = section['output']
                    if result == "fail":
                        result = bcolors.FAIL + result.upper() + bcolors.ENDC
                    elif result == "skip":
                        result = bcolors.WARNING + result.upper() + bcolors.ENDC
                    elif result == "pass":
                        result = bcolors.OKGREEN + result.upper() + bcolors.ENDC
                    else:
                        result = result.upper()
                    print "..........result: {0}".format(result)
                    print "..........audit:\n"
                    for line in cmd:
                        print "{0}".format(line)
                    print "\n..........output:\n"
                    for line in output:
                        if line is not None:
                            print "{0}".format(line)
                    print "\n"
                else:
                    if key != 'expected' and key != 'result' and key != 'output':
                        print "{0:=^100}".format(key)

                if isinstance(section, types.DictionaryType):
                    self.__print_section_items(value)

    def __populate_output(self, section):
        if isinstance(section, types.DictionaryType):
            for key, value in section.items():
                if key == 'audit':
                    result = section['result']
                    self.outputDict[self.curKey] = result
                else:
                    if key != 'expected' and key != 'result' and key != 'output':
                        self.curKey = key

                if isinstance(section, types.DictionaryType):
                    self.__populate_output(value)

    @staticmethod
    def __sort_key(key):
        a = key[0].split(' ')[0]
        t = list(a.split('.'))

        # hack to make dual digits sort well...
        if len(t) == 2:
            t.append(0)

        # hack to make it not blow up when no digits are givesn. i.e. 'audit'
        if len(t) == 1:
            t = [0, 0, 0]

        return int(t[0]), int(t[1]), int(t[2])

    def print_quick(self):
        for item, value in sorted(self.outputDict.items(), key=self.__sort_key):
            if value == "fail":
                value = bcolors.FAIL + value.upper() + bcolors.ENDC
            elif value == "skip":
                value = bcolors.WARNING + value.upper() + bcolors.ENDC
            elif value == "pass":
                value = bcolors.OKGREEN + value.upper() + bcolors.ENDC
            else:
                value = value.upper()
            print "{0:.<115}: {1}".format(item, value)


def process_arguments():
    """Process commandline arguments.

    Keyword arguments:
    none

    Returns:
    args -- object containing argument key/values
    """
    # Argument Parsing with argparse.
    _desc = """CIS audit....
    """
    parser = argparse.ArgumentParser(description=_desc)
    parser.add_argument('-f', '--benchmark_file',
                        help='yaml file containing benchmark info.',
                        required=True)
    parser.add_argument('-v', '--verbose',
                        help='Print Command outputs...',
                        action="store_true")
    args = parser.parse_args()

    # Check for at least one argument.
    return args


def main():
    args = process_arguments()

    b = Benchmark(args.benchmark_file)
    b.collect_data()

    if args.verbose:
        b.print_verbose()
    else:
        b.print_quick()


if __name__ == '__main__':
    try:
        main()
    except IOError, e:
        print str(e)
