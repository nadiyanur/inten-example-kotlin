package id.ac.polbeng.nadiya.eventhandlingexample

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.widget.Toast
import  com.google.android.material.snackbar.Snackbar
import id.ac.polbeng.nadiya.eventhandlingexample.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        // Event handling for button click
        binding.btnDisplayMessage.setOnClickListener {
            Toast.makeText(
                applicationContext,
                "Hello World",
                Toast.LENGTH_LONG
            ).show()
        }

        // Event handling for button long click
        binding.btnDisplayMessage.setOnLongClickListener {
            Toast.makeText(
                applicationContext,
                "Long Click",
                Toast.LENGTH_SHORT
            ).show()
            true // Return true to indicate that the long click has been handled
        }
    }
}
