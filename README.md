# Program Penyelesaian Traveling Salesperson Problem (TSP) dengan Elixir

Program ini adalah implementasi sederhana untuk menyelesaikan Traveling Salesperson Problem (TSP) menggunakan pendekatan Dynamic Programming (mirip dengan algoritma Held-Karp) dalam bahasa Elixir. Program akan membaca matriks jarak antar kota dari sebuah file teks, menghitung tur optimal, dan menampilkan tur beserta total biayanya.

## Struktur File Proyek

Berikut adalah struktur direktori dan file utama dalam proyek ini:
.
├── src/
│   ├── IOHandler.exs   # Modul untuk membaca dan mem-parsing file input matrix
│   ├── main.exs        # Skrip utama untuk menjalankan program
│   └── solver.exs      # Modul TSP yang berisi logika inti penyelesaian masalah
├── test/
│   ├── 1.txt           # Contoh file input untuk pengujian
│   ├── 2.txt           # Contoh file input lainnya
│   └── ...             # File input lainnya
└── README.md           # File ini

## Prasyarat

Sebelum menjalankan program ini, Anda memerlukan:
1.  **Erlang/OTP**
2.  **Elixir**

## Instalasi

Berikut adalah panduan singkat untuk instalasi Erlang dan Elixir, terutama untuk pengguna Windows (karena ini sering ditanyakan). Untuk sistem operasi lain, silakan merujuk ke situs resmi masing-masing.

### 1. Instalasi Erlang/OTP

Elixir berjalan di atas Erlang Virtual Machine (BEAM), jadi Erlang harus diinstal terlebih dahulu.

* **Unduh Erlang:**
    Kunjungi halaman unduhan resmi Erlang: [https://www.erlang.org/downloads](https://www.erlang.org/downloads)
* **Untuk Windows:**
    1.  Unduh "Windows Binary File" (biasanya installer 64-bit).
    2.  Jalankan installer dan ikuti petunjuknya. Pengaturan default biasanya sudah cukup.
    3.  **Penting:** Setelah instalasi, pastikan direktori `bin` dari instalasi Erlang Anda (misalnya, `C:\Program Files\erl<VERSI_OTP>\bin`) ditambahkan ke **PATH environment variable** sistem Anda. Installer biasanya melakukan ini, tetapi ada baiknya untuk diverifikasi.
    4.  Buka Command Prompt atau PowerShell **baru** dan ketik `erl`. Jika berhasil masuk ke Erlang shell, instalasi berhasil. Ketik `halt().` (dengan titik) untuk keluar.
* **Untuk macOS/Linux:** Gunakan package manager seperti Homebrew (`brew install erlang`), `apt`, `yum`, atau build dari source. Ikuti panduan di situs Erlang.

### 2. Instalasi Elixir

Setelah Erlang terinstal, Anda bisa menginstal Elixir.

* **Unduh Elixir:**
    Kunjungi halaman instalasi resmi Elixir: [https://elixir-lang.org/install.html](https://elixir-lang.org/install.html)
* **Untuk Windows:**
    1.  Dari halaman instalasi Elixir, cari link untuk "Windows installers". Unduh installer yang kompatibel dengan versi Erlang/OTP yang baru saja Anda instal.
    2.  Jalankan installer Elixir dan ikuti petunjuknya.
    3.  **Penting:** Installer Elixir biasanya akan otomatis menambahkan direktori `bin` Elixir (misalnya `C:\Program Files (x86)\Elixir\bin`) ke PATH environment variable Anda.
    4.  Buka Command Prompt atau PowerShell **baru** dan ketik `elixir -v`. Jika versi Elixir dan Erlang muncul, instalasi berhasil.
* **Untuk macOS/Linux:** Gunakan package manager seperti Homebrew (`brew install elixir`), `apt`, `yum`, atau metode lain yang dijelaskan di situs Elixir.

**Catatan Kompatibilitas:** Pastikan versi Elixir yang Anda instal kompatibel dengan versi Erlang/OTP Anda. Informasi ini biasanya tersedia di catatan rilis Elixir. (Contoh: Elixir 1.18.x kompatibel dengan Erlang/OTP 27).

## Format File Input

Program ini membaca matriks jarak dari file `.txt`. Formatnya adalah sebagai berikut:

1.  **Baris Pertama:** Satu angka integer yang merepresentasikan jumlah kota (`n`). Komentar setelah angka (dipisahkan spasi atau `//`) akan diabaikan.
2.  **Baris Berikutnya (`n` baris):** Setiap baris merepresentasikan satu baris dari adjacency matrix. Setiap baris harus berisi `n` elemen yang dipisahkan oleh spasi.
    * Elemen bisa berupa angka integer (biaya/jarak).
    * Elemen non-numerik (misalnya, `x`) akan diinterpretasikan sebagai biaya tak hingga (`:infinity`), yang menandakan tidak ada jalur langsung.

**Contoh Isi `input.txt` (untuk 4 kota):**
```txt
4 // Ini adalah jumlah kota
0 10 x 20
10 0 5 x
x 5 0 12
20 x 12 0

## Cara menjalankan Program
1. Buka Terminal atau Command Prompt/PowerShell
2. Pindah ke direktori utama tempat Anda menyimpan proyek ini (direktori yang berisi folder src dan test)
bash '''cd path/ke/direktori/proyek_tsp_anda'''
3. Jalankan Program utama
bash '''elixir src/main.exs'''
4. Ikuti instruksi Program