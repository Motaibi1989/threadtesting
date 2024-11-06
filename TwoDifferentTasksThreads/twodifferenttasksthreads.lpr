program twodifferenttasksthreads;

{$APPTYPE CONSOLE}

uses
  SysUtils, Classes, Fileutil, LCLIntf;


var
ALL,C,D : TStringList;
CriticalSection: Boolean;


type
  TTask1Thread = class(TThread)
  protected
    procedure Execute; override;
  end;

  TTask2Thread = class(TThread)
  protected
    procedure Execute; override;
  end;

procedure TTask1Thread.Execute;
begin
  //while not Terminated do
  begin
    //WriteLn('Task 1 is running...');
    //Sleep(2000); // Sleep for 2 seconds
    WriteLn('FindAllFiles in C:\');
    FindAllFiles(C, 'C:\', '*', true);
    Terminate;
  end;
end;

procedure TTask2Thread.Execute;
begin
  //while not Terminated do
  begin
    //WriteLn('Task 2 is running...');
    //Sleep(3000); // Sleep for 3 seconds
    WriteLn('FindAllFiles in D:\');
    FindAllFiles(D, 'D:\', '*', true);
    Terminate;
  end;
end;

var
  Task1Thread: TTask1Thread;
  Task2Thread: TTask2Thread;

begin
  try


    ALL             := TStringList.Create;
    C               := TStringList.Create;
    D               := TStringList.Create;
    CriticalSection := True;


    Task1Thread     := TTask1Thread.Create(False); // Create and start immediately
    Task2Thread     := TTask2Thread.Create(False); // Create and start immediately

    //ReadLn; // Wait for user input

    //Task1Thread.Terminate; // Request termination for Task1Thread
    //Task2Thread.Terminate; // Request termination for Task2Thread

    Task1Thread.WaitFor; // Wait until Task1Thread finishes
    Task2Thread.WaitFor; // Wait until Task2Thread finishes


    if (CriticalSection) then
    begin
      Try
        CriticalSection:= False;
        ALL.Add('--------------------');
        ALL.Add('D:\');
        ALL.Add('--------------------');
        ALL.Add(D.Text);
      Finally
         CriticalSection:= True;
      end;
    end;


    if (CriticalSection) then
    begin
      Try
        CriticalSection:= False;
        ALL.Add('--------------------');
        ALL.Add('C:\');
        ALL.Add('--------------------');
        ALL.Add(C.Text);
      Finally
         CriticalSection:= True;
      end;
    end;




    All.SaveToFile('ALL.txt');




    Task1Thread.Free; // Clean up Task1Thread
    Task2Thread.Free; // Clean up Task2Thread
    ALL.free;
    C.free;
    D.free;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
