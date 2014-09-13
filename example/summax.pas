program summax;
var i, n, s,m,c: integer;
    //s: string;
begin
  readln(n);

  s := 0;
  m := -10000;
  for i := 1 to n do
  begin
    read(c);
    s := s +c ;
    if c > m then m := c;
  end;
  writeln(s);
  writeln(m);
  //flush(output);
  //close(output);

end.