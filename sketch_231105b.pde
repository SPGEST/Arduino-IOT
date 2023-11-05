import processing.serial.*;   //Serial 추가
import processing.net.*; //net 추가
Serial p; //Serial 변수 p지정
Server s; //Server 변수 s지정
Client c; //Client 변수 c지정
void setup() {
  p = new Serial(this, "COM5", 9600); //Serial 객체 생성
  s = new Server(this, 12345); //Server 객체 생성
}

String msg="hi";
void draw() {
  c = s.available();
  if (c!=null) {
    String m = c.readString();
    if (m.indexOf("GET /")==0) {
      c.write("HTTP/1.1 200 OK\r\n\r\n");
      c.write(msg);
    }
    c.stop();
    
    if (m.indexOf("PUT /")==0) {
      int n = m.indexOf("\r\n\r\n")+4;
      m = m.substring(n);
      m += '\n';
      p.write(m);
      print(m);
    }
  }
  if (p.available()>0) { // Serial 사용가능한지 확인
    String m = p.readStringUntil('\n');
    if (m!=null)  msg = m;
    print(msg);
  }
}
