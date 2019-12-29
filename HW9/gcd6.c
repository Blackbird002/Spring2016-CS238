extern int gcd(int, int);

//This function uses the gcd function in assembly code to get the GCD of 6 numbers.
int gcd6(int a, int b, int c, int d, int e, int f)
{
	int x = gcd(a, gcd(b,c)), y = gcd(gcd(d,e),f);
	return gcd(x,y);
}

