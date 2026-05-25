/*
SPDX-FileContributor:Th3Fi
SPDX-FileType: SOURC
SPDX-License-Identifier: GPLv3
*/
import std.algorithm : splitter;
import std.array : array;
import std.string : chomp, indexOf, indexOfAny;
import std.utf;
import std.concurrency;
import std.stdio;

// struct for async testing
struct Output{
    int[] resultUTF;
    int[] resultMerge;
}

//planned function for allocating the amount of threads used for variable hardware

//makes words
auto tokenMake(string input){
    auto output = input.splitter(" ").array;
    return output;
}

// makes words into utf-8
void tokenEncode(string input, int workerId, Tid parent){
    int[] output;
    {
        int i;
        foreach(c; input.byUTF!char){
            ++output.length;
            output[i] = c;
            ++i;
        }
    }

    int[] resultUTF;
    resultUTF ~= output;

    // writeln(workerId, " | ", input, " | ", output[]); // test worker outputs

    //detect pairs (ballz, haha he said balls in the comments)
    int[] mergePair;
    {
        for(int i = 0; i != ((output.length) - 1) ; ++i){
        // writeln(workerId, " | oper : ", output[i], " ", output[i+1] , " | paired : ", mergePair[]); //debug line for this block
            if(output[i] == output[i + 1]){
                mergePair ~= output[i] + output[i+1];
            }
        }
        //writeln(thisTid, " | ", workerId); // testing for thread number
    }
    int[] resultMerge;
    resultMerge ~= mergePair[];

    Output result = Output(resultUTF, resultMerge);
    send(parent, workerId, cast(immutable) result);
}

void main(){
    //makes a string array automatically now.
    string input = chomp(readln()); //uses chomp to remove /n
    writeln(tokenMake(input));
    auto words = (tokenMake(input));

    // half this code was written on my headset with a 3.5in SPI display, get on my level
    { // prevents count duku from escaping your 2GBs of cloud DDR at AWS
        int count;
        Tid[] workers;
        foreach(word; words){
            workers ~= spawn(&tokenEncode, word, count, thisTid);
            ++count;
        }

        foreach(i; 0 .. count){
            receive((int workerId, Output result){
                writeln(workerId, " | ", result);
            });
        }
    }
}
