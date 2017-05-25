using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Threading;
using System.Diagnostics;
using System.Runtime.InteropServices;

namespace Star_Killer
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }


        private void button1_Click(object sender, EventArgs e)
        {
            Process p = Process.Start("AntiPwny.exe"); 
            Thread.Sleep(500); // Allow the process to open it's window
           SetParent(p.MainWindowHandle, panel1.Handle);

           // Process p = Process.Start("CryptoPreventSetupV8.exe");
           //Thread.Sleep(500); // Allow the process to open it's window
            //SetParent(p.MainWindowHandle, panel1.Handle);

        }

        [DllImport("user32.dll")]
        static extern IntPtr SetParent(IntPtr hWndChild, IntPtr hWndNewParent);


        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            Process p1 = Process.Start("procexp64.exe");
            // Process p = Process.Start("CryptoPreventSetupV8.exe");
            Thread.Sleep(500); // Allow the process to open it's window
            SetParent(p1.MainWindowHandle, panel1.Handle);
        }

        private void button8_Click(object sender, EventArgs e)
        {

        }

        private void button9_Click(object sender, EventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {
            Process p3 = Process.Start("CryptoPreventSetupV8.exe");
            Thread.Sleep(500); // Allow the process to open it's window
            SetParent(p3.MainWindowHandle, panel1.Handle);

        }

        private void button10_Click(object sender, EventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {
            Process p3 = Process.Start("d7.exe");
            Thread.Sleep(500); // Allow the process to open it's window
            SetParent(p3.MainWindowHandle, panel1.Handle);
        }
    }
}
