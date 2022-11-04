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

enum erry: String {
    case happy = "erry_happy"
    case scared = "erry_scared"
    case normal = "erry_normal"
    case shocked = "erry_shocked"
    
    var value: String {
        return self.rawValue
    }
}

enum leona: String {
    case happy = "leona_happy"
    case scared = "leona_scared"
    case normal = "leona_normal"
    case shocked = "leona_shocked"
    
    var value: String {
        return self.rawValue
    }
}

enum gatekeeper: String {
    case happy = "gatekeeper_happy"
    case sad = "gatekeeper_sad"
    case normal = "gatekeeper_normal"
    
    var value: String {
        return self.rawValue
    }
}

enum nameBox: String {
    case erry = "namebox_erry"
    case leona = "namebox_leona"
    case gk_01 = "namebox_01"
    case gk_02 = "namebox_02"
    case gk_03 = "namebox_03"
    case senior = "namebox_senior"
    case teller = "namebox_teller"
    
    var value: String {
        return self.rawValue
    }
}

let ext_tubuh_manusia = [
    DialogueIntro(image: erry.happy.value, label: "Darah merupakan jaringan yang sangat penting dalam tubuh manusia. Di dalam darah, terdapat beberapa komponen yang membentuk darah, salah satunya adalah Sel Darah Merah. Sel Darah Merah bertugas untuk mengangkut oksigen dan karbondioksida yang diedarkan diseluruh tubuh!"),
    DialogueIntro(image: erry.happy.value, label: "Di dalam darah, terdapat beberapa komponen yang membentuk darah, salah satunya adalah Sel Darah Merah. Sel Darah Merah bertugas untuk mengangkut oksigen dan karbondioksida yang diedarkan diseluruh tubuh!"),
    DialogueIntro(image: erry.happy.value, label: "Sel Darah Merah bertugas untuk mengangkut oksigen dan karbondioksida yang diedarkan diseluruh tubuh!"),
]

let ext_serambi_kanan = [
    Dialogue(image: erry.scared.value, label: "Aduh gawat...", name: nameBox.erry.value),
    Dialogue(image: erry.shocked.value, label: "Aku telat!", name: nameBox.erry.value),
    Dialogue(image: erry.scared.value, label: "Aku harus segera sampai.", name: nameBox.erry.value)
]

let ext_gate01 = [
    Dialogue(image: gatekeeper.normal.value, label: "Eh, aku tidak pernah melihat kamu disini. Kamu anak baru?", name: nameBox.gk_01.value),
    Dialogue(image: erry.happy.value, label: "Eh, iya pak. Baru hari pertama menjadi anak magang divisi sel darah merah!", name: nameBox.erry.value),
    Dialogue(image: gatekeeper.happy.value, label: "Oh! Kalau begitu... SELAMAT DATANG DI KOTA KARDIA! Kota Kardia berfungsi untuk memompa darah ke seluruh tubuh dan menerima darah kembali seusai dari paru-paru", name: nameBox.gk_01.value),
    Dialogue(image: erry.shocked.value, label: "Wow, ternyata kota ini keren sekali ya!", name: nameBox.erry.value),
    Dialogue(image: gatekeeper.normal.value, label: "Ya! Jadi, penting sekali untuk menjaga Kota Kardia untuk tetap sehat.", name: nameBox.gk_01.value),
    Dialogue(image: gatekeeper.happy.value, label: "Sekali lagi, selamat datang ya, silahkan masuk.", name: nameBox.gk_01.value),
    Dialogue(image: erry.scared.value, label: "Kalau begitu, saya lari lagi ya pak. Saya sudah dah mau terlambat.", name: nameBox.erry.value),
    Dialogue(image: gatekeeper.happy.value, label: "Semangat, dik!", name: nameBox.gk_01.value)
]

let int_gate01 = [
    Dialogue(image: erry.shocked.value , label: "Aduh maaf, saya sedang terburu-buru. Sini, saya bantu bereskan kertas- kertasnya ya.", name: nameBox.erry.value),
    Dialogue(image: erry.normal.value, label: "Sekali lagi, maaf ya, saya ceroboh.", name: nameBox.erry.value),
    Dialogue(image: leona.normal.value, label: "Oh iya, tidak apa-apa. Terima kasih ya.", name: nameBox.leona.value),
    Dialogue(image: erry.happy.value, label: "Saya ERRY, anak magang divisi sel darah merah.", name: nameBox.erry.value),
    Dialogue(image: leona.happy.value, label: "Saya LEONA. Kebetulan, saya juga  anak magang di divisi sel darah putih.", name: nameBox.leona.value),
    Dialogue(image: erry.normal.value, label: "Wah, halo LEONA, kebetulan saya sedang menuju ke Bilik Kanan. Apakah kamu juga mengarah kesana?", name: nameBox.erry.value),
    Dialogue(image: leona.shocked.value, label: "Ah, sayang sekali saya tidak mengarah kesana.", name: nameBox.leona.value),
    Dialogue(image: erry.happy.value, label: "Ooh, baiklah. Kalau begitu saya lanjut jalan dulu ya. Senang berkenalan dengan kamu!", name: nameBox.erry.value),
    Dialogue(image: leona.happy.value, label: "Iya, hati-hati selalu ya. Sampai jumpa di lain waktu!", name: nameBox.leona.value),
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



