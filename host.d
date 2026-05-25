/*
SPDX-FileContributor:Th3Fi
SPDX-FileType: SOURC
SPDX-License-Identifier: GPLv3
*/
import std.algorithm : splitter;
import std.array : array;
import std.string : chomp, indexOf, indexOfAny;
import std.utf;
import std.parallelism : task;
import std.stdio;

//makes words
auto tokenMake(string input){
    auto output = input.splitter(" ").array;
    return output;
}

// makes words into utf-8
void tokenEncode(string input, int workerId){
    int[] output;
    {
        int i;
        foreach(c; input.byUTF!char){
            ++output.length;
            output[i] = c;
            ++i;
        }
    }
    writeln(workerId, " | ", input, " | ", output[]); // test worker outputs

    //detect pairs (ballz, haha he said balls in the comments)
    {
        int[] mergePair;
        for(int i = 0; i != ((output.length) - 1) ; ++i){
        writeln(workerId, " | oper : ", output[i], " ", output[i+1] , " | paired : ", mergePair[]);
            if(output[i] == output[i + 1]){
                mergePair ~= output[i] + output[i+1];
            }
        }
    }
}

void main(){
    //makes a string array automatically now.
    string input = chomp(readln()); //uses chomp to remove /n
    writeln(tokenMake(input));
    auto words = (tokenMake(input));

    // half this code was written on my headset with a 3.5in SPI display, get on my level
    { // prevents count duku from escaping your 2GBs of cloud DDR at AWS
        int count;
        foreach(word; words){
            auto worker = task!tokenEncode(word, count);
            worker.executeInNewThread();
            ++count;
        }
    }

}
