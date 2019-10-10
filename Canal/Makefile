#
#CC = D:\mingw_w64\mingw64\bin\gcc.exe
#jar cvfm Test.jar META-INF\MANIFEST.MF .\
#java -jar Test.jar
CC = javac 
RM = rm -rf 
LIB = ".;lib/commons-beanutils-1.9.4.jar;lib/commons-lang-2.6.jar;lib/canal.client-1.1.4.jar;lib/slf4j-api-1.7.28.jar;lib/slf4j-simple-1.7.28.jar;lib/protobuf-java-3.10.0.jar;lib/protobuf-java-2.4.1-shaded.jar;" 
all: 
	$(CC)-encoding utf8 -classpath $(LIB)  Test.java
run:
	java -classpath $(LIB) Test
clean:
	$(RM) Test.class *.jar *.class