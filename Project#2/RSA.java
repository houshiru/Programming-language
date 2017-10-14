/*-
    - Author: shou2015, shou2015my.fit.edu
    - Author: name2, e-mail address
    - Course: CSE 4250, Fall 2017
    - Project: Proj2, RSA Project
    -*/
import java.io.*;// for input and output
import java.math.*;// for BigInteger
import java.util.*;// for random

public class RSA{
    public static void main(String args[]) throws IOException
    {
    	BufferedReader bufread = new BufferedReader(new InputStreamReader(System.in));
    	String bufst;
    	BigInteger p, q, e, d, n, lambda;
    	BigInteger message = BigInteger.ZERO, cipher = BigInteger.ZERO;
    	String sseed = System.getProperty("seed");
    	String bits = System.getProperty("bits");
    	long seed = Long.parseLong(sseed);
    	int length = Integer.parseInt(bits);
    	Random rnd;
    	/* generate key */
    	rnd = new Random(seed);
    	p = BigInteger.probablePrime(length, rnd);
    	q = BigInteger.probablePrime(length, rnd);
    	e = BigInteger.probablePrime(length, rnd);
    	n = p.multiply(q);
    	lambda = (p.subtract(BigInteger.ONE)).multiply(q.subtract(BigInteger.ONE));
    	d = e.modInverse(lambda);
    	for (bufst = bufread.readLine();bufst != null;bufst = bufread.readLine()) {
    		switch (bufst.charAt(0)){
    		case 'm': 
    			// encrypt a message
    			// get message from the bufst
    			String[] string = bufst.split(" +");
    			//System.out.println(string[1]);
    			message = new BigInteger(string[1]);
    			// encrypt it
    			cipher = message.modPow(e, n);
    			// print the result of cipher
    			System.out.println("cipher " + cipher);
    			break;
    		case 'c':
    			// decrypt a message
    			// get cipher from the bufst
    			String[] strings = bufst.split(" +");
    			//System.out.println(strings[1]);
    			cipher = new BigInteger(strings[1]);
    			// decrypt it
    			message = cipher.modPow(d, n);
    			// print the result of message
    			System.out.println("message " + message);
    			break;
    		default:
    			break;
    			}
    		}
    	}
    }
