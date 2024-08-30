void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(A0, INPUT);
  pinMode(A1, INPUT);
  pinMode(A2, INPUT);
  pinMode(A3, INPUT);
  pinMode(2, INPUT);
  pinMode(3, INPUT);
  pinMode(4, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  String out_values = "";
  out_values += "a";
  out_values += String(digitalRead(2));
  out_values += "b";
  out_values += String(digitalRead(3));
  out_values += "c";
  out_values += String(analogRead(A0));
  out_values += "d";
  out_values += String(analogRead(A1));
  out_values += "s";
  out_values += String(digitalRead(4));
  out_values += "x";
  out_values += String(analogRead(A2));
  out_values += "y";
  out_values += String(analogRead(A3));
  Serial.println(out_values);
}
