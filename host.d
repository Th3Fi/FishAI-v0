/*
SPDX-FileContributor:Th3Fi
SPDX-FileType: SOURCE
SPDX-License-Identifier: GPLv3
*/
import std.algorithm.mutation: remove;
import std.algorithm : splitter;
import std.array : array;
import std.string : chomp, indexOf, indexOfAny;
import std.conv : to;
import std.utf;
import std.concurrency;
import std.stdio;
//
struct Return{
    int workerId;
    int[] result;
}

struct ReturnIM{
    immutable int workerId;
    immutable int[] result;
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

    //detect pairs (ballz, haha he said balls in the comments)
    {
        for(int i = 0; i != ((output.length) - 1) ; ++i){
            if(output[i] == output[i + 1]){
                output[i] = output[i] + output[i+1];
                output[i + 1] = 0;
            }
            if(output[i] == 0){
                output[i] = output[i + 1];
                output[i + 1] = 0;
            }
        }
    }
    output = remove! (a => a == 0)(output);

    writeln(output, " | ", workerId);
    ReturnIM result = ReturnIM(workerId, cast(immutable) output);
    send(parent, result);
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
        writeln(workers);

        Return[] order;
        order.length = workers.length;
        foreach(i; 0 .. count){
            receive((ReturnIM result){
            order[result.workerId] = cast(Return) result;
            // writeln(workerId, " | " , output); // debug line
            });
        }
        writeln(order);
    }
}
