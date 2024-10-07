package id.ac.polbeng.nadiya.androidaplication

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.TextView

class MainActivity : AppCompatActivity() {
    private lateinit var tvCounter: TextView
    private lateinit var btnAddNumber: Button
    private lateinit var btnSubtractNumber: Button
    private lateinit var btnResetNumber: Button // Tambahkan variabel untuk tombol reset

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        tvCounter = findViewById(R.id.tvCounter)
        btnAddNumber = findViewById(R.id.btnAddNumber)
        btnSubtractNumber = findViewById(R.id.btnSubtractNumber)
        btnResetNumber = findViewById(R.id.btnResetNumber) // Inisialisasi tombol reset

        // Set nilai awal
        tvCounter.text = "1"

        // Set listener untuk tombol tambah
        btnAddNumber.setOnClickListener { addNumber(it) }

        // Set listener untuk tombol kurang
        btnSubtractNumber.setOnClickListener { subtractNumber(it) }

        // Set listener untuk tombol reset
        btnResetNumber.setOnClickListener { resetNumber(it) } // Tambahkan listener untuk reset
    }

    fun addNumber(v: View) {
        val currVal = tvCounter.text.toString().toInt()
        val nextVal = currVal + 1
        tvCounter.text = nextVal.toString()
    }

    fun subtractNumber(v: View) {
        val currVal = tvCounter.text.toString().toInt()
        val nextVal = currVal - 1
        tvCounter.text = nextVal.toString()
    }

    fun resetNumber(v: View) {
        tvCounter.text = "0" // Mengatur nilai tvCounter menjadi 0
    }
}
