program threadtesting;

{$mode objfpc}
uses
  Classes,
  SysUtils;

var
  StrExit             : Int64   = 0;
  CriticalSection     : Boolean = True;

{ TMyThread }
type
AThread = class(TThread)
protected
         procedure Execute; override;
end;

BThread = class(TThread)
protected
         procedure Execute; override;
end;


procedure AThread.Execute;
begin
  while not Terminated do
  begin





    if (CriticalSection) then
      begin
        Try
          CriticalSection:= False;

          inc(StrExit);

        Finally
           CriticalSection:= True;
        end;
      end;





    WriteLn('AThread Execute: '+ IntToStr( StrExit ) );
    Sleep(3000);
end;

end;

procedure BThread.Execute;
begin
  while not Terminated do
  begin



      if (CriticalSection) then
      begin
        Try
          CriticalSection:= False;

          Dec(StrExit);

        Finally
           CriticalSection:= True;
        end;
      end;


    WriteLn('BThread Execute: '+ IntToStr( StrExit ) );
    Sleep(3000);
  end;

end;

var
  T1: AThread;
  T2: BThread;



begin
  //repeat
    t1 := AThread.Create(False);
    t2 := bThread.Create(False);

    WriteLn('-----# MAIN #-----');

    //t1.Start;
    //t2.Start;

    //t1.WaitFor;
    //t2.WaitFor;

    //t1.FreeOnTerminate := true;
    //t2.FreeOnTerminate := true;



    ReadLn;
    WriteLn('-----# MAIN Terminate #-----');

    t1.Terminate;
    t2.Terminate;

    //t1.Free;
    //t2.Free;

  //until StrExit = 20;
end.
