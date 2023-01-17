contract;

storage {
    counter: u64 = 0,
}

abi Counter {
    #[storage(read, write)]
    fn increment();

    #[storage(read)]
    fn counter() -> u64;
}

impl Counter for Contract {
    #[storage(read)]
    fn counter() -> u64 {
        // it's the same as
        // return storage.counter; <-- notice the semicolon at the end
        storage.counter
    }

    #[storage(read, write)]
    fn increment() {
        storage.counter = storage.counter + 1;
    }
}

#[test]
fn can_get_contract_id() {
    let contract_id = 0x6b50d2b4e93c31f53d343c117b4a93ff1de73f8b40fbfd3afe48a8b94169b210;
    let caller = abi(Counter, contract_id);
    // Increment the counter
    let _result = caller.increment {}();

    // Get the current value of the counter
    let result = caller.counter {}();
    // assert(result > 0);
    assert(result == 1);
}
