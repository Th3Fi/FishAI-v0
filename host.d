import std.algorithm : splitter;
import std.array : array;
import std.string : indexOf, indexOfAny;
import std.stdio;

struct Statement{
    static int nextStatementId;
    int statementId;
    string sentence;
    int statementType;
}

struct Neurons{
    double[3] neurons = [1.0, 2.0, 3.0];
    double[3] weights1 = [0.1, 0.3, 0.5];
    double[3] weights2 = [0.2, 0.4 , 0.6];
    double[2] bias = [0.1 , 0.2];
}


//paragraph functions

Statement makeSentence(string sentenceGen, int sentenceType){

    //Statement ID assignment
    int statementId = Statement.nextStatementId;
    ++Statement.nextStatementId;

    //bob the builder
    return Statement(statementId, sentenceGen, sentenceType);
}


string slicer(string paragraph, string findChar, string lastSentence){

    //Initializes a new paragraph using lastSentence
    string newParagraph = paragraph[lastSentence.length..paragraph.length];
    //Find a sentence from paragraph using the length of the slice newParagraph to find the next punctuation
    string sentenceGen = newParagraph[0..(newParagraph.indexOfAny(findChar)+1)];

    return sentenceGen;
}


int sliceContext(string sentenceGen){
    //Sentence type assignment (used for analyzing the context and creating an inference)
    int sentenceType;
    {
    auto statement = sentenceGen.indexOf("!");
    sentenceType = (statement != -1) ? 1 : 0;
    }

    {
    auto statement = sentenceGen.indexOf("?");
    sentenceType = (statement != -1) ? 2 : 0;
    }
    return (sentenceType);
}

// sentence functions

double tokenize(string statement){

}



void main() {
    Statement[] statements;
    {
        string statement = readln();
        string statementContext = ".!?";
        string[] paragraph;
        string lastSentence; //used for slicer calls to be used in a for loop.


        writeln(statement.length);
        for(int i; (lastSentence.length + 1) != statement.length ; ++i){
            writeln(lastSentence.length); // debug lines for testing, uncomment to debug
            writeln(slicer(statement, statementContext, lastSentence));
            lastSentence ~= slicer(statement, statementContext, lastSentence);
            paragraph.length += 1;
            paragraph[i] = lastSentence;
        }


        int i;
            {
            foreach(num; paragraph){
                auto sentence = makeSentence(num,(sliceContext(num)));
                statements.length += 1;
                statements[i] = sentence;
                ++i;
            }
        writeln(statements);


        }
    }


    /*auto question = text.indexOfAny(punctuation);

    writeln(question);
    string delimiters = " ";

    auto tokens = text.splitter(delimiters);

    foreach(token; tokens){
        writeln(token);
    }
    */
}
