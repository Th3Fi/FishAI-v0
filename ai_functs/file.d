/*
SPDX-FileContributor:Th3Fi
SPDX-FileType: SOURCE
SPDX-License-Identifier: GPLv3
*/
module ai_functs.file;

import std.concurrency : spawn, receive, thisTid, Tid, send;
import std.stdio;
import ai_functs.structs;

void fileWrite(Word[] sentence){
    auto file = File("Dict.bin","a");
    foreach(word; sentence){
        file.rawWrite(word.word);
    }
}
