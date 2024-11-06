{

{$mode objfpc}

uses
  {$ifdef unix}
  cthreads,
  {$endif}
  Classes;

type
  TMyThread = class(TThread)
    procedure Execute; override;
  end;

procedure TMyThread.Execute;
begin
  WriteLn('I am thread with ID ',ThreadID);
end;

var
  t1,t2,t3: TThread;
begin
  // create all threads in suspended state
  t1 := TMyThread.Create(true); t1.FreeOnTerminate := true;
  t2 := TMyThread.Create(true); t2.FreeOnTerminate := true;
  t3 := TMyThread.Create(true); t3.FreeOnTerminate := true;

  t1.Start; t2.Start; t3.Start; // start them all
  t1.WaitFor; t2.WaitFor; t3.WaitFor; // wait for them all to finish before exiting main thread
end.

}

 {$mode objfpc}

uses
  {$ifdef unix}
  cthreads,
  {$endif}
  Classes, SysUtils;

type
  TMyThread = class(TThread)
  private
    procedure OutputThreadID;
  protected
    procedure Execute; override;
  end;

procedure TMyThread.OutputThreadID;
begin
  WriteLn('I am thread with ID ', ThreadID);
end;

procedure TMyThread.Execute;
begin
  Synchronize(@OutputThreadID); // Ensure thread output is handled in the main thread
end;

var
  t1, t2, t3: TThread;

begin
  // Create all threads in suspended state
  t1 := TMyThread.Create(true); t1.FreeOnTerminate := true;
  t2 := TMyThread.Create(true); t2.FreeOnTerminate := true;
  t3 := TMyThread.Create(true); t3.FreeOnTerminate := true;

  t1.Start; t2.Start; t3.Start; // Start them all
  t1.WaitFor; t2.WaitFor; t3.WaitFor; // Wait for them all to finish before exiting main thread
end.

