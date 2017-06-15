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
            this.panel1.AutoScroll = false;
            this.panel1.HorizontalScroll.Enabled = false;
            this.panel1.HorizontalScroll.Visible = false;
            this.panel1.HorizontalScroll.Maximum = 0;
            this.panel1.VerticalScroll.Enabled = true;
            this.panel1.VerticalScroll.Visible = true;
            this.panel1.VerticalScroll.Maximum = 0;
            base.VerticalScroll.Visible = true;

            base.HorizontalScroll.Visible = true;


            this.panel1.AutoScroll = true;
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
            _processStartInfo.WorkingDirectory = @".\Pluggys\AntiMeter";
            _processStartInfo.FileName = @"antimeter.exe";
           _processStartInfo.Arguments = " $host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(1000);
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
            myProcess.WaitForExit();
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
            Thread.Sleep(1000);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
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
             _processStartInfo.Arguments = " netstat -a -b  -n -o 25; $host.enternestedprompt()";
             //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(1000);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
            try
            {

                myProcess.WaitForExit();
            }
            catch (InvalidOperationException)
            {
                // purposely do nothing here - the process exited before we told it to.
            }
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
            Thread.Sleep(1000);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
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
            Thread.Sleep(1000);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
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
            Thread.Sleep(1000);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
        }

        private void button23_Click(object sender, EventArgs e)
        {
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"%HOMEDRIVE%%HOMEPATH%";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = " net use; $host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(1000);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
        }

        private void button26_Click(object sender, EventArgs e)
        {
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"%HOMEDRIVE%%HOMEPATH%";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = " net view; $host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(1000);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void button11_Click_1(object sender, EventArgs e)
        {
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"%HOMEDRIVE%%HOMEPATH%";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = " net start; $host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(1000);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
        }

        private void hScrollBar1_Scroll(object sender, ScrollEventArgs e)
        {
          //  panel1.VerticalScroll.Value = bar.Value;
        }

        private void button13_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click_1(object sender, EventArgs e)
        {

        }

        private void button27_Click(object sender, EventArgs e)
        {
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"%HOMEDRIVE%%HOMEPATH%";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = " net session; $host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(1000);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
        }

        private void button28_Click(object sender, EventArgs e)
        {
            // NBT Stat? Doesnt work???
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"%HOMEDRIVE%%HOMEPATH%";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = "nbtstat –s 15; $host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(1000);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
        }

        private void button29_Click(object sender, EventArgs e)
        {
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"%HOMEDRIVE%%HOMEPATH%";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = " net user; $host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(1000);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
        }

        private void button30_Click(object sender, EventArgs e)
        {
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"%HOMEDRIVE%%HOMEPATH%";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = "net localgroup administrators; $host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(1000);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void label8_Click(object sender, EventArgs e)
        {

        }

        private void button31_Click(object sender, EventArgs e)
        {
            //Ram Map
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys\OSfuscate";
            P1.FileName = @"OSfuscate.exe";
            //P4.Arguments = "";
            //P1.CreateNoWindow = true;
            // P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(1000);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
        }

        private void button32_Click(object sender, EventArgs e)
        {
            //BaseLine Analyzer
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys\";
            P1.FileName = @"iexplore.exe";
            P1.Arguments = "https://www.microsoft.com/en-us/download/details.aspx?id=7558";
            //P1.CreateNoWindow = true;
            // P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(10);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();

        }

        private void panel10_Paint(object sender, PaintEventArgs e)
        {

        }

        private void label10_Click(object sender, EventArgs e)
        {

        }

        private void button33_Click(object sender, EventArgs e)
        {
            // KIll CMD
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"%HOMEDRIVE%%HOMEPATH%";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = "taskkill /F /IM cmd.exe /T; $host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(1000);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
        }

        private void button34_Click(object sender, EventArgs e)
        {
            // KIll powershell
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"%HOMEDRIVE%%HOMEPATH%";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = "taskkill /F /IM powershell.exe /T";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(1000);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
        }

        private void button35_Click(object sender, EventArgs e)
        {
            // Open DNS
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"%HOMEDRIVE%%HOMEPATH%";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = "netsh interface show interface; netsh dnsclient add dnsserver 'Local Area Connection' 208.67.222.222 1; netsh dnsclient add dnsserver 'Local Area Connection' 208.67.220.220 2; $host.enternestedprompt();$host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(1500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
        }

        private void button14_Click(object sender, EventArgs e)
        {
            //photo Analyzer
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys\";
            P1.FileName = @"iexplore.exe";
            P1.Arguments = "https://29a.ch/photo-forensics/#forensic-magnifier";
            //P1.CreateNoWindow = true;
            // P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(10);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button36_Click(object sender, EventArgs e)
        {
            //Quip QUuip
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys\";
            P1.FileName = @"iexplore.exe";
            P1.Arguments = "http://quipqiup.com";
            //P1.CreateNoWindow = true;
            // P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(10);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
        }

        private void button37_Click(object sender, EventArgs e)
        {
            //RumKIn
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys\";
            P1.FileName = @"iexplore.exe";
            P1.Arguments = "http://rumkin.com/tools/cipher/";
            //P1.CreateNoWindow = true;
            // P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(10);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
        }

        private void button38_Click(object sender, EventArgs e)
        {
            //DCODE
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys\";
            P1.FileName = @"iexplore.exe";
            P1.Arguments = "http://www.dcode.fr/tools-list";
            //P1.CreateNoWindow = true;
            // P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(10);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button39_Click(object sender, EventArgs e)
        {
            //Setup py
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"./Scripts";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = "./Get_Setup_evolve.bat;$host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(1500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
        }

        private void button40_Click(object sender, EventArgs e)
        {
            // Rubber Glue
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"./Pluggys/RubberGlue";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = "python rubberglue.py 2222;$host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(1500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
            myProcess.WaitForExit();
        }

        private void button41_Click(object sender, EventArgs e)
        {
            // test cat
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"./Scripts/SANS-SEC505-master/scripts/Day1-PowerShell";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = "powershell -noexit -executionpolicy bypass -File Control_GUI_App.ps1;$host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(1500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button42_Click(object sender, EventArgs e)
        {
            // Block Cortana
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"./Scripts/SANS-SEC505-master/scripts/Day1-PowerShell";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = "powershell -noexit -executionpolicy bypass -File Block-Cortana.ps1;$host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(1500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button43_Click(object sender, EventArgs e)
        {
            // Check Services
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"./Scripts/SANS-SEC505-master/scripts/Day2-Hardening/Services";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = "powershell -noexit -executionpolicy bypass -File Get-ServiceIdentity.ps1;$host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(11500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button44_Click(object sender, EventArgs e)
        {
            // reset Pass
     
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"./Scripts";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = "powershell -noexit -executionpolicy bypass -File easypassword2.ps1;$host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(11500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button45_Click(object sender, EventArgs e)
        {
            // User Settings Windows
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"./Scripts";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = "netplwiz;$host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(11500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button24_Click(object sender, EventArgs e)
        {
            //Vahalla Files
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys";
            P1.FileName = @"honeypot.exe";
            //P4.Arguments = "";
            //P1.CreateNoWindow = true;
            // P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(1000);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button47_Click(object sender, EventArgs e)
        {
            //RumKIn
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys\";
            P1.FileName = @"iexplore.exe";
            P1.Arguments = "https://ninite.com";
            //P1.CreateNoWindow = true;
            // P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(10);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button16_Click(object sender, EventArgs e)
        {
            //ADS Detetor
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys\ADSMangager";
            P1.FileName = @"ADSManager.exe";
            //P4.Arguments = "";
            //P1.CreateNoWindow = true;
            // P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button48_Click(object sender, EventArgs e)
        {
            //System Explorer
            ProcessStartInfo P1 = new ProcessStartInfo();
            P1.WorkingDirectory = @".\Pluggys\SystemExplorer";
            P1.FileName = @"SystemExplorerSetup.exe";
            //P4.Arguments = "";
            //P1.CreateNoWindow = true;
            // P1.WindowStyle = ProcessWindowStyle.Normal;
            Process myProcess = Process.Start(P1);
            Thread.Sleep(500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button49_Click(object sender, EventArgs e)
        {
            // User Settings Windows
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"./Scripts";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = "ping 8.8.8.8;$host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(11500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }

        private void button50_Click(object sender, EventArgs e)
        {
            // Check Services
            ProcessStartInfo _processStartInfo = new ProcessStartInfo();
            _processStartInfo.WorkingDirectory = @"./Scripts/";
            _processStartInfo.FileName = @"powershell.exe";
            _processStartInfo.Arguments = "powershell -noexit -executionpolicy bypass -File Get-MemoryDump.ps1;$host.enternestedprompt()";
            //_processStartInfo.Arguments = "-noexit; cd ./Pluggys ; $host.enternestedprompt()";
            _processStartInfo.CreateNoWindow = true;
            Process myProcess = Process.Start(_processStartInfo);
            Thread.Sleep(11500);
            SetParent(myProcess.MainWindowHandle, panel1.Handle);
        }
    }
}
