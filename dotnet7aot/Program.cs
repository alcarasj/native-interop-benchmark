using System.Runtime.InteropServices;

namespace DotNet7Aot
{
    internal class Program
    {
        static void Main()
        {
            var name = "Interop";
            var greeting = SayHello(name);
            if (greeting != "Hello Interop!")
            {
                throw new Exception("Program returned incorrect greeting!");
            }
        }

        private static string SayHello(string name) => $"Hello {name}!";
    }
}