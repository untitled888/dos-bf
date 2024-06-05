rem dos-bf v1.0 by Untitled888

rem Some constants
#define MAX_PROG_LEN 5000
#define MAX_TAPE_LEN 5000

rem The user's program
dim program(MAX_PROG_LEN) as Byte
dim as Integer lastInstruction = 1

rem Tape
dim nums(MAX_TAPE_LEN) as Integer

rem Data and instruction pointers
dim as Integer dp = 1
dim as Integer ip = 1

rem Matching loop ends and beginnings
dim loopBeginnings(MAX_PROG_LEN) as Integer
dim loopEnds(MAX_PROG_LEN) as Integer
dim as Integer loopCounter = 1

rem Checking if the filename was entered
if command(1) = "" then
    print "Usage: bf.exe [FILE]"
    end
end if

rem Checking if the file exists
#include "file.bi"
if fileExists(command(1)) = 0 then
    print "Error: file not found"
    end
end if

rem Reading the file
open command(1) for Input as #1
dim progString as String
line input #1, progString
close #1

rem Checking program length
if len(progString) > MAX_PROG_LEN then
    print "Error: maxinum program length exceeded"
    end
end if

rem Parsing the file
dim loopStack(MAX_PROG_LEN) as Integer
dim as Integer stackTop = 1
for i as Integer = 0 to len(progString) - 1 step 1
    select case chr(progString[i])
        case "<"
            program(lastInstruction) = 1
        case ">"
            program(lastInstruction) = 2
        case "-"
            program(lastInstruction) = 3
        case "+"
            program(lastInstruction) = 4
        case "."
            program(lastInstruction) = 5
        case ","
            program(lastInstruction) = 6
        case "["
            program(lastInstruction) = 7
            loopStack(stackTop) = i + 1
            stackTop += 1
        case "]"
            if stackTop = 1 then
                print "Error: unmatched ']' at position " & i + 1
                end
            end if
            program(lastInstruction) = 8
            stackTop -= 1
            dim as Integer beginning = loopStack(stackTop)
            loopBeginnings(i + 1) = beginning
            loopEnds(beginning) = i + 1
        case else
            print "Error: unknown symbol at position " & i + 1
            end
    end select
    lastInstruction += 1
next i

rem Checking if any "[" is unmatched
if stackTop > 1 then
    print "Error: unmatched '[' at position " & loopStack(stackTop) + 1
    end
end if

rem Executing
do while ip < lastInstruction
    select case program(ip)
        case 1
            rem Checking end of tape
            if dp = 1 then
                print "Error: end of tape reached at position " & ip
                end
            end if
            dp -= 1
        case 2
            rem Checking end of tape
            if dp = MAX_TAPE_LEN then
                print "Error: end of tape reached at position " & ip
                end
            end if
            dp += 1
        case 3
            nums(dp) -= 1
        case 4
            nums(dp) += 1
        case 5
            print nums(dp)
        case 6
            input nums(dp)
        case 7
            if nums(dp) = 0 then ip = loopEnds(ip)
        case 8
            if nums(dp) <> 0 then ip = loopBeginnings(ip)
    end select
    ip += 1
loop
end