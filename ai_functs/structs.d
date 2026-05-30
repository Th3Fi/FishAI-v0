module ai_functs.structs;

import std.stdio;

struct Word{
    int wordPos;
    ushort[] word;
}

struct WordIM{
    immutable int wordPos;
    immutable ushort[] word;
}
