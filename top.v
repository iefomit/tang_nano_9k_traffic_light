module top (
    input  wire clk,       // 27 MHz clock
    input  wire reset_n,   // S2 button
    output wire led_green,
    output wire led_yellow,
    output wire led_red
);

    // 1 second at 27 MHz
    reg [24:0] clock_count = 0;

    // How long we've been in the current light
    reg [1:0] light_count = 0;

    // 0 = green, 1 = yellow, 2 = red
    reg [1:0] state = 0;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            clock_count <= 0;
            light_count <= 0;
            state <= 0;
        end
        else if (clock_count == 25'd26999999) begin
            clock_count <= 0;

            case (state)

                2'd0: begin // green
                    if (light_count == 2) begin
                        state <= 1;
                        light_count <= 0;
                    end
                    else begin
                        light_count <= light_count + 1;
                    end
                end

                2'd1: begin // yellow
                    state <= 2;
                    light_count <= 0;
                end

                2'd2: begin // red
                    if (light_count == 2) begin
                        state <= 0;
                        light_count <= 0;
                    end
                    else begin
                        light_count <= light_count + 1;
                    end
                end

                default: begin
                    state <= 0;
                    light_count <= 0;
                end

            endcase
        end
        else begin
            clock_count <= clock_count + 1;
        end
    end

    // LEDs on the Tang Nano are active-low
    assign led_green  = (state == 0) ? 0 : 1;
    assign led_yellow = (state == 1) ? 0 : 1;
    assign led_red    = (state == 2) ? 0 : 1;

endmodule