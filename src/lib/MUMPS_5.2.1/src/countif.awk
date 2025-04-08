#! /usr/bin/awk -f
tolower($0) ~ /^[~ ]+if.+then *(!.)*$/ {countif++;}# print "if: ", NR}
tolower($0) ~ /^[~ ]+end *if *$/ {countendif++; if (countendif > countif) {print "extra endif at ", NR;  exit 1} }
END{print "if=", countif, "; endif=", countendif}
