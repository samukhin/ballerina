import ballerina/lang.runtime;
import ballerina/io;
import ballerina/random;

public function main() {

    var a = 0.0;
    var c = 0;

    @strand {thread: "any"}
    worker A {
        while true {
            a += random:createDecimal();
            c += 1;
            //io:println(a);
            runtime:sleep(<decimal>random:createDecimal());
        }
    }

    @strand {thread: "any"}
    worker B {
        while true {
            a -= random:createDecimal();
            c += 1;
            //io:println(a);
            runtime:sleep(<decimal>random:createDecimal());
        }
    }

    @strand {thread: "any"}
    worker C {
        while true {
            io:println([a, c]);
            runtime:sleep(1);
        }
    }
    wait A;
    wait B;
    wait C;
}
