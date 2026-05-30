module ai_functs.breakdown;

import ai_functs.structs;
import std.array: array;
import std.algorithm: splitter;
import std.concurrency : spawn, receive, thisTid, Tid, send;
import std.stdio;
import std.string : chomp;
import std.utf : byUTF;

//breakdown

void makeWord(int wordPos, string input, Tid parent){
    ushort[] output;
    {
        int i;
        foreach(c; input.byUTF!char){
            ++output.length;
            output[i] = c;
            ++i;
        }
    }
    const(ushort[]) terminator = [0 , 0];
    output ~= terminator;

    auto word = WordIM(wordPos, cast(immutable) output[]);
    send(parent, word);
}

Word[] readTokenize(){
    string res = chomp(readln());
    auto reslts = res.splitter(" ").array;
    Word[] sentence;
    sentence.length = reslts.length;
    {
        int i;
        foreach(rslt; reslts){
            spawn(&makeWord, i, rslt, thisTid);
            ++i;
        }

        foreach(w; 0 .. i){
            receive((WordIM word){
            sentence[word.wordPos] = cast(Word) word;
            });
        }
    }
    return sentence;
}
