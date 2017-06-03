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


     

        [DllImport("user32.dll")]
         static extern IntPtr SetParent(IntPtr hWndChild, IntPtr hWndNewParent);
        //private extern static bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, int uFlags);
        private void button1_Click(object sender, EventArgs e)
        {
            //antiPwny
         
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys";
            P1.FileName = @"AntiPwny.exe";
            //P4.Arguments = "";
            //P1.CreateNoWindow = true;
            // P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys";
            P1.FileName = @"procexp.exe";
            //P4.Arguments = "";
            //P1.CreateNoWindow = true;
            P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button8_Click(object sender, EventArgs e)
        {

        }

        private void button9_Click(object sender, EventArgs e)
        {
            // User Access
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @".\Pluggys";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = "$host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button3_Click(object sender, EventArgs e)
        {
            //Cryptobutton
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys";
            P1.FileName = @"CryptoPreventSetupV8.exe";
            //P4.Arguments = "";
            //P1.CreateNoWindow = true;
            // P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button10_Click(object sender, EventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {
            // D7
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys\d7";
            P1.FileName = @"d7.exe";
            //P4.Arguments = "";
            //P1.CreateNoWindow = true;
            // P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button11_Click(object sender, EventArgs e)
        {
            //AntiMeter
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys\AntiMeter";
            P1.FileName = @"AntiMeter.exe";
            //P4.Arguments = "";
            //P1.CreateNoWindow = true;
            // P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void button6_Click(object sender, EventArgs e)
        {
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"%HOMEDRIVE%%HOMEPATH%";
            _processStartInfo.FileName = @"powershell.exe";
             _processStartInfo.Arguments = " netstat -a -b  -n -o; $host.enternestedprompt()";
             //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button17_Click(object sender, EventArgs e)
        {
            //TCP
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys\SysInternals";
            P1.FileName = @"TCPView.exe";
            //P4.Arguments = "";
            //P1.CreateNoWindow = true;
            // P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button18_Click(object sender, EventArgs e)
        {
            //Ram Map
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys\SysInternals";
            P1.FileName = @"RAMMap.exe";
            //P4.Arguments = "";
            //P1.CreateNoWindow = true;
            // P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button15_Click(object sender, EventArgs e)
        {
            //Shadow Files
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys";
            P1.FileName = @"ShadowExplorerPortable.exe";
            //P4.Arguments = "";
            //P1.CreateNoWindow = true;
            // P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }
    }
}
