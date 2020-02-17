program tubeRev;
uses crt, classes;

{NAMA : DIMITRI IRFAN DZIDNY}
{NIM : 1301180256}
{KELAS : IF-42-11}


const harga_economy = 1000000;
const harga_superEconomy = 800000;

type passenger = record 
    nama, familyName, JenisTiket : string;
    codeBook : longint;
    hargaTiket : longint;
    nomorKursi : integer;
    abjadKursi : char;
    jadwal : string;
    end;

type seat_economy = array [1..10,'A'..'F'] of passenger;
type seat_superEconomy = array [11..30,'A'..'F'] of passenger;

var 
    
    dataPass : passenger;
    dataSeat_economy : seat_economy;
    dataSeat_superEconomy : seat_superEconomy; 
    i,stop,stop_global,pick,flag : integer;
    j : char;

    //save data 
    saveEco : file of seat_economy;
    saveSup : file of seat_superEconomy;



procedure proceed;
var 
    proc : char;
begin 
    write('input lagi ? (y/n) : ');
    readln(proc);
    if proc = 'n' then 
        stop := 1
    else if proc = 'y' then 
        stop := 0
    else 
    begin 
        repeat  
            writeln('Error ');
            writeln;
            write('input lagi ? (y/n) : ');
            readln(proc);
        until (proc = 'n') or (proc = 'y')
    end;
    

end;

procedure output_pinjad(var dataSeat : passenger);
begin 
    clrscr;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    writeln;
    write(' | Code Booking : ',dataSeat.codeBook);
    writeln(' | Class : ',dataSeat.JenisTiket);
    writeln;
    writeln(' | Nama : ',dataSeat.nama);
    writeln(' | Nama Keluarga : ',dataSeat.familyName);
    writeln(' | Harga Tiket : ',dataSeat.hargaTiket);
    writeln(' | Jadwal : ',dataSeat.jadwal);
    writeln;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    

end;


procedure output(var dataSeat : passenger);
begin 
    clrscr;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    writeln;
    write(' | Code Booking : ',dataSeat.codeBook);
    writeln(' | Class : ',dataSeat.JenisTiket);
    writeln;
    writeln(' | Nama : ',dataSeat.nama);
    writeln(' | Nama Keluarga : ',dataSeat.familyName);
    writeln(' | Seat : ',dataSeat.nomorKursi,dataPass.abjadKursi);
    if (dataSeat.JenisTiket = 'economy') or (dataSeat.JenisTiket = 'Economy') then
        writeln(' | Harga Tiket : ',harga_economy)
    else if (dataSeat.JenisTiket = 'super economy') or (dataSeat.JenisTiket = 'Super Economy') then
        writeln(' | Harga : ',dataSeat.hargaTiket);
    writeln;
    writeln(' | Jadwal : ',dataSeat.jadwal);
    writeln;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    

end;


procedure map_economy(var dataSeat : seat_economy);
// Untuk check keadaan kursi ekonomi
begin 
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    writeln;
    writeln;
    writeln('       Economy Seat');
    writeln('    ____________________');
    writeln;
    for i := 1 to 10 do begin 
        write(' [',i,'] ');
        for j := 'A' to 'C' do begin 
            if (dataSeat[i][j].codeBook = 0) or (dataSeat[i][j].codeBook > 7000) then 
                write(j,'/')
            else 
                write('x','/');
        end;
        write('|    |');
        for j := 'D' to 'F' do begin 
            if (dataSeat[i][j].codeBook = 0) or (dataSeat[i][j].codeBook > 7000) then
                write(j,'/')
            else    
                write('x','/');
        end;
        writeln;
    end;
    writeln('                                                       x = sudah terisi    ');
    writeln;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    
    writeln;
end;


procedure map_superEconomy(var dataSeat : seat_superEconomy);
// Untuk check keadaan kursi ekonomi
begin 
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    writeln;
    writeln('       Super Economy Seat');
    writeln('   _____________________________');
    writeln;
    for i := 11 to 30                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        do begin 
        write(' [',i,'] ');
        for j := 'A' to 'C' do begin 
            if (dataSeat[i][j].codeBook = 0) or (dataSeat[i][j].codeBook > 7000) then 
                write(j,'/')
            else 
                write('x','/');
        end;
        write('|    |');
        for j := 'D' to 'F' do begin 
            if (dataSeat[i][j].codeBook = 0) or (dataSeat[i][j].codeBook > 70000) then
                write(j,'/')
            else    
                write('x','/');
        end;
        writeln;
    end;
    writeln('                                                       x = sudah terisi    ');
    writeln;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    
    writeln;
end;


function ketersediaan_economy(i : integer ; j : char): boolean;
// False if full
begin  
    ketersediaan_economy := (dataSeat_economy[i][j].codeBook = 0) or (dataSeat_economy[i][j].codeBook > 7000);  
end;

function ketersediaan_superEconomy(i : integer ; j : char): boolean;
begin 
    ketersediaan_superEconomy := (dataSeat_superEconomy[i][j].codeBook = 0) or (dataSeat_superEconomy[i][j].codeBook > 7000);     
end;


function search_economy(dataSeat : seat_economy ; code : integer ; nama : string): boolean;
// Untuk nyari data passenger berdasarkan nomor booking (ekonomi)
begin 

    for i := 1 to 10 do begin 
        for j := 'A' to 'F' do begin 
            if (code = dataSeat[i][j].codeBook) and (nama = dataSeat[i][j].familyName) then
                search_economy := (code = dataSeat[i][j].codeBook) and (nama =dataSeat[i][j].familyName );
        end;
    end;    
end;

function search_superEconomy(dataSeat : seat_superEconomy ; code : integer): boolean;
// Untuk nyari data passenger berdasarkan nomor booking (ekonomi)
begin 

    for i := 11 to 30 do begin 
        for j := 'A' to 'F' do begin 
            if code = dataSeat[i][j].codeBook then
                search_superEconomy := code = dataSeat[i][j].codeBook;
        end;
    end;    
end;

function search_superEconomy(dataSeat : seat_superEconomy ; dataPass : passenger ): boolean;
// Untuk nyari data passenger berdasarka nomor booking (super ekonomi)
begin 

    for i := 1 to 10 do begin 
        for j := 'A' to 'F' do begin 
            search_superEconomy := dataPass.codeBook = dataSeat[i][j].codeBook;
        end;
    end;    
end;

function code_random_pinjad(dataPass : passenger): integer;
// Untuk generate booking number random
begin

    Randomize;
    i := 0;
    dataPass.codeBook := 0;
    repeat 
        i := i + 1;
        dataPass.codeBook := dataPass.codeBook + random(7000) + 8000;
    until i = 2;
    code_random_pinjad := dataPass.codeBook;
end;

function code_random(dataPass : passenger): integer;
// Untuk generate booking number random
begin

    Randomize;
    i := 0;
    dataPass.codeBook := 0;
    repeat 
        i := i + 1;
        dataPass.codeBook := dataPass.codeBook + random(1000) + 2000;
    until i = 2;
    code_random := dataPass.codeBook;
end;

procedure input_kursi_economy_upgrade(var dataSeat : seat_economy ; var dataPass : passenger);
// Assign data Passenger ke dalam kursi ekonomi [i][j]

begin 
    clrscr;
    dataPass.JenisTiket := 'Economy';
    map_economy(dataSeat);
    write('Nomor Kursi : '); readln(dataPass.nomorKursi);
    if dataPass.nomorKursi > 10 then 

    begin 
        repeat 
            writeln('Kursi Ekonomi 1 - 10');
            write('Nomor Kursi : '); readln(dataPass.nomorKursi);
        until dataPass.nomorKursi <= 10;
    end;

    write('Abjad Kursi : '); readln(dataPass.abjadKursi);

    if ketersediaan_economy(dataPass.nomorKursi,dataPass.abjadKursi) = false then
    begin
        repeat
            writeln('kursi penuh pilih yang lain');
            begin 

                write('Nomor Kursi : '); readln(dataPass.nomorKursi);
                if dataPass.nomorKursi > 10 then 

                begin 
                    repeat 
                        writeln('Kursi Ekonomi 1 - 10');
                        write('Nomor Kursi : '); readln(dataPass.nomorKursi);
                    until dataPass.nomorKursi <= 10;
                end;

                write('Abjad Kursi : '); readln(dataPass.abjadKursi);
            end;
        until ketersediaan_economy(dataPass.nomorKursi,dataPass.abjadKursi) = True
    end;
    dataPass.codeBook := code_random(dataPass);
    dataPass.jadwal := '29 Mei 2016';
    dataSeat[dataPass.nomorKursi][dataPass.abjadKursi] := dataPass;
    output(dataPass);
    readln;
end;
    
    
procedure input_kursi_economy(var dataSeat : seat_economy ; var dataPass : passenger);
// Assign data Passenger ke dalam kursi ekonomi [i][j]

begin 
    clrscr;
    map_economy(dataSeat);
    write('Nomor Kursi : '); readln(dataPass.nomorKursi);
    if dataPass.nomorKursi > 10 then 

    begin 
        repeat 
            writeln('Kursi Ekonomi 1 - 10');
            write('Nomor Kursi : '); readln(dataPass.nomorKursi);
        until dataPass.nomorKursi <= 10;
    end;

    write('Abjad Kursi : '); readln(dataPass.abjadKursi);

    if ketersediaan_economy(dataPass.nomorKursi,dataPass.abjadKursi) = false then
    begin
        repeat
            writeln('kursi penuh pilih yang lain');
            begin 

                write('Nomor Kursi : '); readln(dataPass.nomorKursi);
                if dataPass.nomorKursi > 10 then 

                begin 
                    repeat 
                        writeln('Kursi Ekonomi 1 - 10');
                        write('Nomor Kursi : '); readln(dataPass.nomorKursi);
                    until dataPass.nomorKursi <= 10;
                end;

                write('Abjad Kursi : '); readln(dataPass.abjadKursi);
            end;
        until ketersediaan_economy(dataPass.nomorKursi,dataPass.abjadKursi) = True
    end;
    dataPass.codeBook := code_random(dataPass);
    dataPass.jadwal := '29 Mei 2016';
    dataPass.hargaTiket := harga_economy;
    dataSeat[dataPass.nomorKursi][dataPass.abjadKursi] := dataPass;
    output(dataPass);
    readln;
    

end;

procedure input_kursi_superEconomy(var dataSeat : seat_superEconomy ; var dataPass : passenger);
// Assign data Passenger ke dalam kursi super ekonomi [i][j]

begin
    clrscr;
    map_superEconomy(dataSeat);
    write('Nomor Kursi (angka) : '); readln(dataPass.nomorKursi); 
    if dataPass.nomorKursi <= 10 then 
    
    begin
        repeat 
            writeln('Kursi Ekonomi 11 - 30 ');
            write('Nomor Kursi (angka) : '); readln(dataPass.nomorKursi); 
        until dataPass.nomorKursi > 10;
    end;

    write('Abjad Kursi (huruf) : '); readln(dataPass.abjadKursi);

    if ketersediaan_superEconomy(dataPass.nomorKursi,dataPass.abjadKursi) = false then
    begin
        repeat
            writeln('kursi penuh pilih yang lain');
            begin 

                write('Nomor Kursi : '); readln(dataPass.nomorKursi);
                if dataPass.nomorKursi <= 10 then 

                begin 
                    repeat 
                        writeln('Kursi Ekonomi 1 - 10');
                        write('Nomor Kursi : '); readln(dataPass.nomorKursi);
                    until dataPass.nomorKursi > 10;
                end;

                write('Abjad Kursi : '); readln(dataPass.abjadKursi);
            end;
        until ketersediaan_superEconomy(dataPass.nomorKursi,dataPass.abjadKursi) = True
    end;
    dataPass.codeBook := code_random(dataPass);
    dataPass.jadwal := '29 Mei 2016';
    dataPass.hargaTiket := harga_superEconomy;
    dataSeat[dataPass.nomorKursi][dataPass.abjadKursi] := dataPass;
    output(dataPass);
    readln;

end;

procedure input_data(var dataPass : passenger); 

begin 
    write('Nama Depan : '); readln(dataPass.nama);
    writeln;
    write('Nama Belakang : '); readln(dataPass.familyName);
    writeln;
    write('Jenis Tiket (economy or super economy) : '); readln(dataPass.JenisTiket);
    writeln;
    if (dataPass.JenisTiket = 'economy') or (dataPass.JenisTiket = 'Economy') then
        input_kursi_economy(dataSeat_economy,dataPass)
    else if (dataPass.JenisTiket = 'super economy') or (dataPass.JenisTiket = 'Super Economy') then 
        input_kursi_superEconomy(dataSeat_superEconomy,dataPass);

end;

procedure outputEco(dataSeat : seat_economy ); 

begin 
    clrscr;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    writeln;
    for i := 1 to 10 do begin 
        for j := 'A' to 'F' do begin 
            if (ketersediaan_economy(i,j)) = false then begin
                write('Data Penumpang : '); 
                write(dataSeat[i][j].familyName,', ',dataSeat[i][j].nama,' ');
                write(dataSeat[i][j].JenisTiket,' ');
                write(dataSeat[i][j].nomorKursi,dataSeat[i][j].abjadKursi,' ');
                writeln;
            end;
        end;
    end;    
    writeln;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    
    readln;
end;

procedure outputSup(dataSeat : seat_superEconomy);

begin
    clrscr;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    writeln;
    for i := 11 to 30 do begin 
        for j := 'A' to 'F' do begin 
            if (ketersediaan_superEconomy(i,j)) = false then begin
                write('Data Penumpang : '); 
                write(dataSeat[i][j].familyName,', ',dataSeat[i][j].nama,' ');
                write(dataSeat[i][j].JenisTiket,' ');
                write(dataSeat[i][j].nomorKursi,dataSeat[i][j].abjadKursi,' ');
                writeln;
            end;
        end;
    end;    
    writeln;
    writeln('[ *| |* ]===================================================================[ *| |* ]');

    readln;
end;




procedure menu_cetakTiket();
begin 
    clrscr;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    writeln;
    writeln('   Menu Cetak Tiket');
    writeln(' _____________________');
    writeln;
    write('   Code Book : '); readln(dataPass.codeBook);
    writeln;
    write('   Nama Keluarga : '); readln(dataPass.familyName);
    writeln;
    writeln;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    flag := 0;
    for i := 1 to 30 do 
    begin 
        for j := 'A' to 'F' do 
        begin
            if dataSeat_economy[i][j].codeBook = dataPass.codeBook then 
            begin 
                flag := 1;
                writeln;
                writeln('===============================================================================');
                write(' | Code Booking : ',dataSeat_economy[i][j].codeBook);
                write(' | Jadwal : ', dataSeat_economy[i][j].jadwal);
                writeln(' | Class : ',dataSeat_economy[i][j].JenisTiket);
                writeln;
                writeln(' | Nama : ',dataSeat_economy[i][j].nama);
                writeln(' | Nama Keluarga : ',dataSeat_economy[i][j].familyName);
                writeln(' | Seat : ',dataSeat_economy[i][j].nomorKursi,dataSeat_economy[i][j].abjadKursi);
                writeln(' | Harga : ',dataSeat_economy[i][j].hargaTiket);
                writeln;
                writeln('                                                                         Etihad');
                writeln('==============================================================================='); 
                readln;
            end
            else if  dataSeat_superEconomy[i][j].codeBook = dataPass.codeBook then 
            begin 
                flag := 1;
                writeln;
                writeln('===============================================================================');
                write(' | Code Booking : ',dataSeat_superEconomy[i][j].codeBook);
                writeln(' | Class : ',dataSeat_superEconomy[i][j].JenisTiket);
                writeln;
                writeln(' | Nama : ',dataSeat_superEconomy[i][j].nama);
                writeln(' | Nama Keluarga : ',dataSeat_superEconomy[i][j].familyName);
                writeln(' | Seat : ',dataSeat_superEconomy[i][j].nomorKursi,dataSeat_superEconomy[i][j].abjadKursi);
                writeln(' | Harga : ',dataSeat_superEconomy[i][j].hargaTiket);
                writeln;
                writeln('                                                                         Etihad');
                writeln('===============================================================================');
                readln;
            end;
        end;
    end; 
    if flag = 0 then
    begin 
        if dataSeat_economy[i][j].codeBook <> dataPass.codeBook then 
        begin
                writeln;
                writeln('Data not found');
                readln;
        end
        else if dataSeat_superEconomy[i][j].codeBook <> dataPass.codeBook then
        begin 
            writeln;
            writeln('Data not found');
            readln;
        end;       
    end;             
end;

procedure menu_upgradeTiket(var dataPass : passenger);
var 
    flag_x : integer;
    kode : integer;
    namaf : string;
begin 
    clrscr;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    writeln;
    writeln('   Ketentuan : ');
    writeln('       1. Upgrade Tiket hanya diperbolehkan untuk penumpang super ekonomi');
    writeln('       2. Upgrade Tiket akan dikenakan biaya tambahan');
    writeln('       3. Biaya tambahan untk upgrade adalah sebesar Rp200.000');
    writeln('       4. Updrage tidak dikenakan biaya');
    writeln;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    
    readln;
    clrscr;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    writeln;
    writeln('   Menu Upgrade Tiket ');
    writeln(' _________________________');
    writeln;
    write('     Code Booking : '); readln(kode);
    writeln;
    write('     Nama Keluarga : '); readln(namaf);
    writeln;
    writeln;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    flag_x := 0;
    for i := 11 to 30 do 
    begin 
        for j := 'A' to 'F' do 
        begin 
            if dataSeat_superEconomy[i][j].codeBook = kode then 
            begin   
                flag_x := 1;
                dataSeat_superEconomy[i][j].codeBook := 0;
                dataPass.nama := dataSeat_superEconomy[i][j].nama;
                dataPass.familyName := dataSeat_superEconomy[i][j].familyName;
                input_kursi_economy_upgrade(dataSeat_economy,dataPass);
                output(dataPass);
                
            end;
            if flag_x = 1 then 
            break;
            
        end;
        if flag_x = 1 then 
            break;
    end;
    if flag_x = 0 then begin
        writeln;
        write('data not found');
        readln;
    end;
end;

procedure jadwal_tersedia();
begin 
    clrscr;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    writeln;
    writeln('   Jadwal Tersedia ');
    writeln('  __________________');
    writeln;
    writeln('   1. 30 Mei 2016');
    writeln;
    writeln;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    readln;
    
end;
procedure menu_pindahJadwal(var dataPass : passenger);
var 
    flag_x : integer;
    kode : integer;
    namaf : string;
begin 
    clrscr;
    flag_x := 0;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    writeln;
    writeln('   Ketentuan : ');
    writeln('       1. pindah jadwal untuk kelas economy tidak dikenakan biaya tambahan');
    writeln('       2. Biaya tambahan untuk kelas super economy sebesar Rp100.000');
    writeln;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    readln;
    clrscr;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    writeln;
    writeln('   Menu Pindah Jadwal');
    writeln('  _____________________');
    writeln;
    write('     Code Booking : '); readln(kode);
    writeln;
    write('     Nama Keluarga : '); readln(namaf);
    writeln;
    writeln;
    writeln('[ *| |* ]===================================================================[ *| |* ]');
    jadwal_tersedia;
    for i := 1 to 30 do 
    begin 
        for j := 'A' to 'F' do 
        begin 
            if dataSeat_superEconomy[i][j].codeBook = dataPass.codeBook then 
            begin 
                flag_x := 1;
                dataSeat_superEconomy[i][j].codeBook := 0;
                dataSeat_superEconomy[i][j].codeBook := code_random_pinjad(dataPass);
                dataPass.codeBook := dataSeat_superEconomy[i][j].codeBook;
                dataPass.jadwal := '30 Mei 2016';
                dataPass.hargaTiket := harga_superEconomy + 100000;
                output_pinjad(dataPass);
            end
            else if dataSeat_economy[i][j].codeBook = dataPass.codeBook then 
            begin 
                flag_x := 1;
                dataSeat_economy[i][j].codeBook := 0; 
                dataSeat_economy[i][j].codeBook := code_random_pinjad(dataPass);
                dataPass.codeBook := dataSeat_economy[i][j].codeBook;
                dataPass.jadwal := '30 Mei 2016';
                dataPass.hargaTiket := harga_economy;
                output_pinjad(dataPass);
            end;
        end;
    end;
    if flag_x = 0 then begin
        writeln;
        write('data not found');
    end;
    readln;
end;


procedure menu_bookingTiket();
var 
    m,n: integer;
begin 
    clrscr;
    m := 0;
    n := 0;
    repeat 
        n := n + 1;
        clrscr; 
        writeln('[ *| |* ]===================================================================[ *| |* ]');
        writeln;
        writeln('   Menu Booking Tiket                   ');
        writeln('__________________________');
        writeln;
        input_data(dataPass);
        if (n < 4) and (m < 4) and (m + n < 4) then 
            proceed;
        writeln;
        writeln('[ *| |* ]===================================================================[ *| |* ]');

    until (n = 4) or (stop = 1) or (m = 4) or (m + n = 4);

end;

procedure menu_utama();
var     
    pick : integer;
begin
    pick := 0;
    clrscr;
    writeln;
    writeln;
    writeln;
    writeln;
    writeln;
    writeln;
    writeln;
    writeln;
    writeln;
    writeln('                                           [ *| |* ]===================================================================[ *| |* ]');
    writeln;
    writeln('                                                                                ETIHAD AIRWAYS');
    writeln;
    writeln('                                                                               Abu Dhabi - Jeddah');
    writeln;
    writeln('                                                                                  29 Mei 2016');
    writeln;
    writeln;
    writeln;
    writeln('                                               Menu Utama ');
    writeln('                                           _____________________');
    writeln;
    writeln;
    writeln('                                              1. Booking Tiket');
    writeln;
    writeln('                                              2. Upgrade Tiket or Updrage ');
    writeln;
    writeln('                                              3. Cetak Tiket ');
    writeln;
    writeln('                                              4. Pindah Jadwal ');
    writeln;
    writeln('                                              5. List Penumpang Ekonomi ');
    writeln;      
    writeln('                                              6. List Penumpang Super Ekonomi ');   
    writeln;                             
    writeln('                                                                                                 0.Exit');
    writeln;
    writeln;
    writeln('                                         [ *| |* ]===================================================================[ *| |* ]');
    writeln;
    write('                                                Pilih Menu : '); readln(pick);
    case pick of 
        1 : menu_bookingTiket; 
        2 : menu_upgradeTiket(dataPass);
        3 : menu_cetakTiket;
        4 : menu_pindahJadwal(dataPass);
        5 : outputEco(dataSeat_economy);
        6 : outputSup(dataSeat_superEconomy);
        0 : stop_global := 1;
    end;
    
 
end;

begin 
    Assign(saveEco,'economy.dat');
    Assign(saveSup,'superEconomy.dat');
    reset(saveEco);
    reset(saveSup);
    while (not eof(saveEco)) and (not eof(saveSup)) do begin 
        read(saveEco,dataSeat_economy);
        read(saveSup,dataSeat_superEconomy);
    end;
    close(saveEco);
    close(saveSup);   

    stop_global := 0;
    repeat 
      
        menu_utama();
    until stop_global = 1;
    Assign(saveEco,'economy.dat');
    Assign(saveSup,'superEconomy.dat');
    rewrite(saveEco);
    rewrite(saveSup);
    write(saveEco,dataSeat_economy);
    write(saveSup,dataSeat_superEconomy);
    close(saveEco);
    close(saveSup);       
   
end.
