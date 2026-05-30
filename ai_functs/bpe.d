module ai_functs.bpe;

import std.array: array;
import std.algorithm: splitter;
import std.concurrency : spawn, receive, thisTid, Tid, send;
import std.stdio;
import ai_functs.structs;

Word[] bytePairEncode(Word[] sentence){
        foreach(word; sentence){
                spawn(&wordEncode, cast(WordIM) word, thisTid);
        }
        Word[] h;
        return h;
}

void wordEncode(WordIM word, Tid parent){
    foreach(c; word.word){
        writeln(c);
    }
}

