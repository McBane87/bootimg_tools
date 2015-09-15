CC=$(CROSS_COMPILE)gcc
AR=$(CROSS_COMPILE)ar rcs
CFLAGS=-Ofast -w
LDFLAGS=-static -s -L./libmincrypt
LIBS=-lmincrypt

ifneq ($(SYSROOT),)
	CFLAGS += --sysroot $(SYSROOT)
endif

ALL:
	$(CC) $(CFLAGS) -c libmincrypt/sha.c -o libmincrypt/sha.o
	$(CC) $(CFLAGS) -c libmincrypt/rsa.c -o libmincrypt/rsa.o
	$(CC) $(CFLAGS) -c libmincrypt/sha256.c -o libmincrypt/sha256.o
	$(CC) $(CFLAGS) -c libmincrypt/dsa_sig.c -o libmincrypt/dsa_sig.o
	$(CC) $(CFLAGS) -c libmincrypt/p256.c -o libmincrypt/p256.o
	$(CC) $(CFLAGS) -c libmincrypt/p256_ec.c -o libmincrypt/p256_ec.o
	$(CC) $(CFLAGS) -c libmincrypt/p256_ecdsa.c -o libmincrypt/p256_ecdsa.o
	$(AR) libmincrypt/libmincrypt.a libmincrypt/sha.o libmincrypt/rsa.o libmincrypt/sha256.o libmincrypt/dsa_sig.o libmincrypt/p256_ec.o libmincrypt/p256_ecdsa.o
	$(CC) $(CFLAGS) -c unpackbootimg.c
	$(CC) $(CFLAGS) -c mkbootimg.c
	$(CC) $(CFLAGS) -c mkbootimg_android.c
	$(CC) $(CFLAGS) -c dtbTool.c
	$(CC) $(LDFLAGS) -o mkbootimg mkbootimg.o $(LIBS)
	$(CC) $(LDFLAGS) -o mkbootimg_android mkbootimg_android.o $(LIBS)
	$(CC) $(LDFLAGS) -o unpackbootimg unpackbootimg.o $(LIBS)
	$(CC) $(LDFLAGS) -o dtbTool dtbTool.o

clean:
	rm -f *.o mkbootimg mkbootimg_android unpackbootimg dtbTool libmincrypt/*.o libmincrypt/libmincrypt.*
	
