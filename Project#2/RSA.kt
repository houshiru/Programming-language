/*-
    - Author: shou2015, shou2015my.fit.edu
    - Author: Yihua Xu, yxu2017@my.fit.edu
    - Course: CSE 4250, Fall 2017
    - Project: Proj2, RSA Project
    -*/

import java.io.*// for input and output
import java.math.*// for BigInteger
import java.util.*// for random

object RSA {
    @Throws(IOException::class)
    @JvmStatic
    fun main(args: Array<String>) {
        val bufread = BufferedReader(InputStreamReader(System.`in`))
        var bufst: String?
        val p: BigInteger
        val q: BigInteger
        val e: BigInteger
        val d: BigInteger
        val n: BigInteger
        val lambda: BigInteger
        var message: BigInteger
        var cipher: BigInteger
        val sseed = System.getProperty("seed")?: "23434"
        val bits = System.getProperty("bits")?: "100"
        val seed = java.lang.Long.parseLong(sseed)
        val length = Integer.parseInt(bits)
        val rnd: Random
        /* generate key */
        rnd = Random(seed)
        p = BigInteger.probablePrime(length, rnd)
        q = BigInteger.probablePrime(length, rnd)
        e = BigInteger.probablePrime(length, rnd)
        n = p.multiply(q)
        lambda = p.subtract(BigInteger.ONE).multiply(q.subtract(BigInteger.ONE))
        d = e.modInverse(lambda)
        bufst = bufread.readLine()
        while (bufst != null) {
            when (bufst[0]) {
                'm' -> {
                    // encrypt a message
                    // get message from the bufst
                    val string = bufst.split(" +".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()
                    //System.out.println(string[1]);
                    message = BigInteger(string[1])
                    // encrypt it
                    cipher = message.modPow(e, n)
                    // print the result of cipher
                    println("cipher " + cipher)
                }
                'c' -> {
                    // decrypt a message
                    // get cipher from the bufst
                    val strings = bufst.split(" +".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()
                    //System.out.println(strings[1]);
                    cipher = BigInteger(strings[1])
                    // decrypt it
                    message = cipher.modPow(d, n)
                    // print the result of message
                    println("message " + message)
                }
                else -> {
                }
            }
            bufst = bufread.readLine()
        }
    }
}
