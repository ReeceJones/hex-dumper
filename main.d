import std.stdio, std.algorithm, std.file, std.range, std.math;

int main(string[] args)
{
  if (args.length < 2)
    return 1;
  File *f = new File(args[1], "r");
  //we take chunks of 10 bytes from the File
  //we take size/chunks of the chunks from the file
  //for each chunk we pass a lambda as a template
  //inside of that lambda we have a print statement to print out the values
  //we then pass another lambda to the writeln statement
  //this lambda either passes a '.' or the character by checking the hex value of the character
  //whats cool about this is that you can use lambdas within lambdas
  //we use the functions of the lambda for each for map the characters
  if (args.length > 2 && args[2] == "--header-only")
  {
    f.byChunk(10).take(1).each!(
      t => writefln!"%(%02X %)\t%s"(t, t.map!(c => c < 0x20 || c > 0x7E ? '.' : char(c))));
  }
  else
  {
    f.byChunk(10).take(cast(int)ceil(cast(float)f.size() / 10.0)).each!(
      t => writefln!"%(%02X %)\t%s"(t, t.map!(c => c < 0x20 || c > 0x7E ? '.' : char(c))));
  }
  return 0;
}
