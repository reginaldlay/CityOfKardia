//
//  Dialogue.swift
//  studySpriteKit
//
//  Created by Vincensa Regina on 14/10/22.
//

import Foundation
import SpriteKit

struct Dialogue {
    var image: String?
    var label: String?
    var name: String? = "Name"
}

struct DialogueIntro {
    var image: String?
    var label: String?
}

let erry = "Erry"
let leona = "Leona"
let satpam_01 = "Satpam 01"
let satpam_02 = "Satpam 02"
let senior = "Senior"

let erry_happy = "Erry/erry_happy"
let erry_scared = "Erry/erry_scared"
let erry_normal = "Erry/erry_normal"
let erry_shocked = "Erry/erry_shocked"

let leona_happy = "Leona/leona_happy"
let leona_scared = "Leona/leona_scared"
let leona_normal = "Leona/leona_normal"
let leona_shocked = "Leona/leona_shocked"

let gatekeeper_happy = "Gatekeeper/gatekeeper_happy"
let gatekeeper_sad = "Gatekeeper/gatekeeper_sad"
let gatekeeper_normal = "Gatekeeper/gatekeeper_normal"

let ext_tubuh_manusia = [
    DialogueIntro(image: erry_happy, label: "Darah merupakan jaringan yang sangat penting dalam tubuh manusia. Di dalam darah, terdapat beberapa komponen yang membentuk darah, salah satunya adalah Sel Darah Merah. Sel Darah Merah bertugas untuk mengangkut oksigen dan karbondioksida yang diedarkan diseluruh tubuh!"),
    DialogueIntro(image: erry_happy, label: "Di dalam darah, terdapat beberapa komponen yang membentuk darah, salah satunya adalah Sel Darah Merah. Sel Darah Merah bertugas untuk mengangkut oksigen dan karbondioksida yang diedarkan diseluruh tubuh!"),
    DialogueIntro(image: erry_happy, label: "Sel Darah Merah bertugas untuk mengangkut oksigen dan karbondioksida yang diedarkan diseluruh tubuh!"),
]

let ext_serambi_kanan = [
    Dialogue(image: erry_shocked, label: "Aduh gawat...", name: erry),
    Dialogue(image: erry_scared, label: "Aku telat!", name: erry),
    Dialogue(image: erry_shocked, label: "Aku harus segera sampai.", name: erry)
]

let ext_gate01 = [
    Dialogue(image: gatekeeper_normal, label: "Eh, aku tidak pernah melihat kamu disini. Kamu anak baru?", name: satpam_01),
    Dialogue(image: erry_happy, label: "Eh, iya pak. Baru hari pertama menjadi anak magang divisi sel darah merah!", name: erry),
    Dialogue(image: gatekeeper_happy, label: "Oh! Kalau begitu... SELAMAT DATANG DI KOTA KARDIA! Kota Kardia berfungsi untuk memompa darah ke seluruh tubuh dan menerima darah kembali seusai dari paru-paru", name: satpam_01),
    Dialogue(image: erry_shocked, label: "Wow, ternyata kota ini keren sekali ya!", name: erry),
    Dialogue(image: gatekeeper_normal, label: "Ya! Jadi, penting sekali untuk menjaga Kota Kardia untuk tetap sehat.", name: satpam_01),
    Dialogue(image: gatekeeper_happy, label: "Sekali lagi, selamat datang ya, silahkan masuk.", name: satpam_01),
    Dialogue(image: erry_scared, label: "Kalau begitu, saya lari lagi ya pak. Saya sudah dah mau terlambat.", name: erry),
    Dialogue(image: gatekeeper_happy, label: "Semangat, dik!", name: satpam_01)
]

let int_gate01 = [
    Dialogue(image: erry_shocked , label: "Aduh maaf, saya sedang terburu-buru. Sini, saya bantu bereskan kertas- kertasnya ya."),
    Dialogue(image: erry_normal, label: "Sekali lagi, maaf ya, saya ceroboh."),
    Dialogue(image: leona_normal, label: "Oh iya, tidak apa-apa. Terima kasih ya."),
    Dialogue(image: erry_happy, label: "Saya ERRY, anak magang divisi sel darah merah."),
    Dialogue(image: leona_normal, label: "Saya LEONA. Kebetulan, saya juga  anak magang di divisi sel darah putih."),
    Dialogue(image: erry_normal, label: "Wah, halo LEONA, kebetulan saya sedang menuju ke Bilik Kanan. Apakah kamu juga mengarah kesana?"),
    Dialogue(image: leona_shocked, label: "Ah, sayang sekali saya tidak mengarah kesana."),
    Dialogue(image: erry_happy, label: "Ooh, baiklah. Kalau begitu saya lanjut jalan dulu ya. Senang berkenalan dengan kamu!"),
    Dialogue(image: leona_happy, label: "Iya, hati-hati selalu ya. Sampai jumpa di lain waktu!"),
]

let int_guild = [
    Dialogue(image: "", label: "Halo, kamu Erry ya? Di daftar anak magang hanya kamu saja yang belum absen."),
    Dialogue(image: "", label: "Iya, pak! Maaf, saya terlambat."),
    Dialogue(image: "", label: "Baiklah, jangan diulangi lagi ya."),
    Dialogue(image: "", label: "Nah, karena tinggal kamu saja yang belum dapat briefing, sekalian saya jelaskan tugas kamu langsung ya sekarang."),
    Dialogue(image: "", label: "Baik, siap pak!")
]

let int_guild_explanation = [
    Dialogue(image: "", label: "")
]

let ext_gate03_1 = [
    Dialogue(image: "", label: "Halo, pak! Saya harus mengambil oksigen, nih!"),
    //Gatekeeper menjelaskan paru2
]

let ext_gate03_2 = [
    Dialogue(image: "", label: "Kalau saya ingin mengambil oksigen, di mana ya tempatnya?", name: "Erry"),
    Dialogue(image: "", label: " Oh! Kamu bisa langsung masuk ke ruangan ALVEOLUS! untuk menemui si Teller, dia akan menjelaskan semuanya lebih lanjut di sana~", name: "Satpam 03"),
    Dialogue(image: "", label: "Teller paru-paru akan menjelaskan semuanya lebih lanjut di sana~", name: "Satpam 03"),
]

let int_alveolus = [
    Dialogue(image: "", label: "Permisi, Saya ditugaskan mengambil oksigen. Apakah benar disini?", name: "Erry"),
    Dialogue(image: "", label: "Iya, benar. Adakah REQUEST NOTE dari guild?", name: "Teller"),
    Dialogue(image: "", label: "Oh, iya ini, kak.", name: "Erry"),
    Dialogue(image: "", label: "Ditunggu, sebentar ya!", name: "Teller")
]



