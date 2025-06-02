# Program Penyelesaian Traveling Salesperson Problem (TSP) dengan Elixir

Program ini adalah implementasi sederhana untuk menyelesaikan Traveling Salesperson Problem (TSP) menggunakan pendekatan Dynamic Programming (mirip dengan algoritma Held-Karp) dalam bahasa Elixir. Program akan membaca matriks jarak antar kota dari sebuah file teks, menghitung tur optimal, dan menampilkan tur beserta total biayanya.

## Struktur File Proyek

Berikut adalah struktur direktori dan file utama dalam proyek ini:
```
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
```

## Prasyarat

Sebelum menjalankan program ini, Anda memerlukan:
1.  **Erlang/OTP**
2.  **Elixir**

## Instalasi

### 1. Instalasi Erlang/OTP

Elixir berjalan di atas Erlang Virtual Machine (BEAM), jadi Erlang harus diinstal terlebih dahulu.

* **Unduh Erlang:** [https://www.erlang.org/downloads](https://www.erlang.org/downloads)

### 2. Instalasi Elixir

* **Unduh Elixir:** [https://elixir-lang.org/install.html](https://elixir-lang.org/install.html)

## Format File Input

Program ini membaca matriks jarak dari file `.txt`. Formatnya adalah sebagai berikut:

1.  **Baris Pertama:** Satu angka integer yang merepresentasikan jumlah kota (`n`)
2.  **Baris Berikutnya (`n` baris):** Setiap baris merepresentasikan satu baris dari adjacency matrix. Setiap baris harus berisi `n` elemen yang dipisahkan oleh spasi.
    * Elemen bisa berupa angka integer (biaya/jarak).
    * Elemen non-numerik (misalnya, `x`) akan diinterpretasikan sebagai biaya tak hingga (`:infinity`), yang menandakan tidak ada jalur langsung.

**Contoh Isi `input.txt` (untuk 4 kota):**
```txt
4 // Ini adalah jumlah kota
0 10 15 20
10 0 5 12
10 5 0 12
20 21 12 0
```

## Cara menjalankan Program
1. Buka Terminal atau Command Prompt/PowerShell
2. Pindah ke direktori utama tempat Anda menyimpan proyek ini (direktori yang berisi folder src dan test)
```cd path/ke/direktori/proyek_tsp_anda```
3. Jalankan Program utama
```elixir src/main.exs```
4. Ikuti instruksi Program

## Algoritma TSP Solver
Algoritma ini menyelesaikan permasalahan Travelling Salesman Problem (TSP) menggunakan pendekatan Dynamic Programming dengan Bitmasking-like style, khususnya metode Held-Karp.

### Alur Kerja Algoritma
1. Inisialisasi Jarak Awal
Mulai dari node 0 ke semua node lain, disimpan dalam bentuk map (subset, last_node) sebagai key.
2. Pembangunan Tabel DP
Untuk setiap ukuran subset dari 3 hingga n, algoritma membentuk semua kombinasi simpul (kecuali 0) lalu menghitung biaya minimum untuk mencapai setiap simpul dalam subset tersebut dari simpul lain dalam subset tersebut.
3. Kembali ke Titik Awal
Setelah semua subset dihitung, algoritma mencari biaya total terendah untuk kembali ke node 0 dari semua kemungkinan node terakhir.
4. Rekonstruksi Rute
Berdasarkan tabel DP yang telah dibuat, rute optimal dibangun ulang dari simpul terakhir kembali ke titik awal.


## Contoh Hasil Eksekusi Program untuk 6 test case di folder test/
**1.txt**
![image](https://github.com/user-attachments/assets/87536a6e-f98a-4bb4-9030-de4c6af4e2f3)
**2.txt**
![image](https://github.com/user-attachments/assets/ec7b3fc4-e97a-49af-8fd1-3c7979d1e202)
**3.txt**
![image](https://github.com/user-attachments/assets/144daf5f-ef7d-44d5-b7a2-354132b09558)
**4.txt**
![image](https://github.com/user-attachments/assets/5e96bd7a-9f3f-4de0-86d6-d9b87c371c03)
**5.txt**
![image](https://github.com/user-attachments/assets/7ac6aa8a-9c58-4171-bf8c-3750dc73ffaf)
