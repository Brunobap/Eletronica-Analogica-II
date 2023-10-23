void main() {
     RCON = 0;
     
     INTCON = 0b11000000;
     INTCON2 = 0b00;
     INTCON3 = 0;
     
     PIE1 = 0;
     PIE2 = 0;
     
     IPR1 = 0;
     IPR2 = 0;
}