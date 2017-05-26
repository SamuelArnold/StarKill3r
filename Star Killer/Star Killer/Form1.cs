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
            //this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
           // this.TopMost = true;
            WindowState = FormWindowState.Maximized;

        }


        private void button1_Click(object sender, EventArgs e)
        {



            ProcessStartInfo theProcess = new ProcessStartInfo("AntiPwny.exe");
            theProcess.WindowStyle = ProcessWindowStyle.Normal;
            Process p = Process.Start(theProcess);
           // Process p = Process.Start("AntiPwny.exe"); 
            Thread.Sleep(500); // Allow the process to open it's window
            //Program.MoveWindow(p.MainWindowHandle, 0, 0, 500, 500, true);
            SetParent(p.MainWindowHandle, panel1.Handle);

           // Process p = Process.Start("CryptoPreventSetupV8.exe");
           //Thread.Sleep(500); // Allow the process to open it's window
            //SetParent(p.MainWindowHandle, panel1.Handle);

        }

        [DllImport("user32.dll")]
         static extern IntPtr SetParent(IntPtr hWndChild, IntPtr hWndNewParent);
        //private extern static bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, int uFlags);


        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {

            ProcessStartInfo theProcess = new ProcessStartInfo("procexp.exe");

            theProcess.WindowStyle = ProcessWindowStyle.Normal;

              Process p1 = Process.Start(theProcess);
           // Process p1 = Process.Start("procexp64.exe");
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
            //Process p3 = Process.Start("CryptoPreventSetupV8.exe");
            //Thread.Sleep(500); // Allow the process to open it's window
            //SetParent(p3.MainWindowHandle, panel1.Handle);

        }

        private void button10_Click(object sender, EventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {
           // Process p3 = Process.Start("d7.exe");
           // Thread.Sleep(500); // Allow the process to open it's window
         //   SetParent(p3.MainWindowHandle, panel1.Handle);
        }
    }
}
