import "@stdlib/deploy";

message Add {
    amount: Int as uint32;
}

message Multiply{
    val: Int as uint32;
}

message Divide{
    val: Int as uint32;
}

contract SampleTactContract with Deployable {

    owner: Address;
    counter: Int as uint32;

    init(owner: Address) {
        self.owner = owner;
        self.counter = 1;
    }

    fun add(v: Int) {
        
        // Check sender
        let ctx: Context = context();
        require(ctx.sender == self.owner, "Invalid sender");
        
        // Update counter
        self.counter = (self.counter + v);
    }

    receive(msg: Add) {
        self.add(msg.amount);
    }

    receive(msg: Multiply) {
        self.counter = self.counter * msg.val;
    }

    receive(msg: Divide) {
        self.counter = self.counter / msg.val;
    }

    receive("increment") {
        self.counter = self.counter + 1;
    }

    receive("test") {
        self.add(1);
        self.reply("test".asComment());
    }

    get fun counter(): Int {
        return self.counter;
    }

    get fun owner(): Address {
        return self.owner;
    }
}