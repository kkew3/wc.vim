#!/usr/bin/env python3
import argparse
import unicodedata
import sys


def make_parser():
    parser = argparse.ArgumentParser(
        description=('This script strips wide characters from FILE or stdin '
                     'if one is not provided, and outputs to stdout.'))
    parser.add_argument('filename', metavar='FILE', nargs='?')
    return parser


def stripwchar(istream, ostream):
    for line in istream:
        cbuf = []
        for c in line:
            if unicodedata.east_asian_width(c) in 'FW':
                cbuf.append(' ')
            else:
                cbuf.append(c)
        ostream.write(''.join(cbuf))


def main():
    args = make_parser().parse_args()
    try:
        if args.filename is None:
            stripwchar(sys.stdin, sys.stdout)
        else:
            with open(args.filename, encoding='utf-8') as infile:
                stripwchar(infile, sys.stdout)
    except KeyboardInterrupt:
        pass
    except BrokenPipeError:
        sys.stderr.close()


if __name__ == '__main__':
    main()
