using System.Runtime.InteropServices;

namespace DotNet7AotPInvoke
{
    internal class Program
    {
        private class NativeMethods
        {
            [DllImport("NativeStuff.so")]
            internal static extern IntPtr say_hello([MarshalAs(UnmanagedType.LPStr)] string name);
        }

        static void Main()
        {
            var name = "Interop";
            var greetingIntPointer = NativeMethods.say_hello(name);
            var greeting = System.Runtime.InteropServices.Marshal.PtrToStringAnsi(greetingIntPointer);
            if (greeting != "Hello Interop!")
            {
                throw new Exception("Program returned incorrect greeting!");
            }
        }
    }
}