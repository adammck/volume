#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

AVAudioRecorder *recorder;

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
        NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys: nil];
        NSError *error;
        
        recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];

        if (!recorder) {
            fprintf(stderr, "Something went wrong\n");
            return 1;
        }

        [recorder prepareToRecord];
        recorder.meteringEnabled = YES;
        [recorder record];

        while(true) {
            [recorder updateMeters];
            printf("%f\n", [recorder averagePowerForChannel:0]);
            sleep(1);
        }
    }

    return 0;
}
