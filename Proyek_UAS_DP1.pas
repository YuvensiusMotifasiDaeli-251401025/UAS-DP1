program StopwatchTimer;
uses crt, sysutils;

type
  // Struktur record untuk menyimpan data waktu
  TWaktu = record
    jam: integer;
    menit: integer;
    detik: integer;
  end;

{ ----------------------------------------------------- }
{ FUNCTION: Menambahkan angka 0 di depan jika < 10 }
function LeadingZero(x: integer): string;
begin
  if x < 10 then
    LeadingZero := '0' + IntToStr(x)
  else
    LeadingZero := IntToStr(x);
end;

{ ----------------------------------------------------- }
{ FUNCTION: Mengubah record waktu menjadi format HH:MM:SS }
function FormatWaktu(w: TWaktu): string;
begin
  FormatWaktu :=
    LeadingZero(w.jam) + ':' +
    LeadingZero(w.menit) + ':' +
    LeadingZero(w.detik);
end;

{ ----------------------------------------------------- }
{ PROCEDURE: STOPWATCH (menghitung naik) }
procedure Stopwatch;
var
  w: TWaktu;
  tombol: char;
begin
  // Set awal waktu 00:00:00
  w.jam := 0;
  w.menit := 0;
  w.detik := 0;

  // Menu mulai stopwatch
  repeat
    clrscr;
    writeln('===== STOPWATCH =====');
    writeln('Tekan [S] untuk mulai, [Q] untuk kembali ke menu');
    tombol := ReadKey;
  until tombol in ['s','S','q','Q'];

  if tombol in ['q','Q'] then Exit;

  { ----------- MULAI STOPWATCH ----------- }
  repeat
    clrscr;
    writeln('===== STOPWATCH BERJALAN =====');
    writeln('Tekan [X] untuk menghentikan');
    writeln;
    writeln('Waktu: ', FormatWaktu(w));

    delay(1000);      // jeda 1 detik
    Inc(w.detik);     // detik bertambah

    // Jika detik = 60 → reset & menit bertambah
    if w.detik = 60 then
    begin
      w.detik := 0;
      Inc(w.menit);
    end;

    // Jika menit = 60 → reset & jam bertambah
    if w.menit = 60 then
    begin
      w.menit := 0;
      Inc(w.jam);
    end;

  until KeyPressed and (ReadKey in ['x','X']);

  // Hasil akhir
  clrscr;
  writeln('STOPWATCH DIHENTIKAN!');
  writeln('Hasil akhir = ', FormatWaktu(w));
  writeln;
  writeln('Tekan apapun untuk kembali...');
  ReadKey;
end;

{ PROCEDURE: TIMER  }
procedure Timer;
var
  w: TWaktu;
  tombol: char;
begin
  clrscr;
  writeln('===== TIMER =====');

  // Input awal
  write('Masukkan Jam   : '); readln(w.jam);
  write('Masukkan Menit : '); readln(w.menit);
  write('Masukkan Detik : '); readln(w.detik);

  repeat
    clrscr;
    writeln('===== TIMER BERJALAN =====');
    writeln('Tekan [X] untuk menghentikan timer');
    writeln;
    writeln('Sisa waktu: ', FormatWaktu(w));

    delay(1000);

    // Cek tombol X untuk stop manual
    if KeyPressed then
    begin
      tombol := ReadKey;
      if tombol in ['x','X'] then
      begin
        clrscr;
        writeln('TIMER DIHENTIKAN!');
        writeln('Sisa terakhir: ', FormatWaktu(w));
        writeln;
        writeln('Tekan apapun untuk kembali...');
        ReadKey;
        Exit;
      end;
    end;

    // Hitung mundur
    Dec(w.detik);

    // Jika detik habis → pinjam 1 menit
    if w.detik < 0 then
    begin
      w.detik := 59;
      Dec(w.menit);
    end;

    // Jika menit habis → pinjam 1 jam
    if w.menit < 0 then
    begin
      w.menit := 59;
      Dec(w.jam);
    end;

  until (w.jam = 0) and (w.menit = 0) and (w.detik = 0); // Ulangi terus hitung mundur sampai waktu benar-benar habis total.

  // Waktu habis
  clrscr;
  writeln('===== WAKTU HABIS! =====');
  writeln('Tekan apapun...');
  ReadKey;
end;


{ PROGRAM UTAMA }
var
  pilihan: char;

begin
  repeat
    clrscr;
    writeln('========== MENU UTAMA ==========');
    writeln('[1] Stopwatch');
    writeln('[2] Timer');
    writeln('[3] Keluar');
    writeln('================================');
    write('Pilih menu (1-3): ');
    pilihan := ReadKey;

    case pilihan of
      '1': Stopwatch;
      '2': Timer;
      '3': begin
             clrscr;
             writeln('Terima kasih telah menggunakan program!');
             halt;
           end;
    else
      writeln;
      writeln('Pilihan tidak valid!');
      delay(600);
    end;

  until false;
end.

