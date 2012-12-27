//
//  ViewController.m
//  BluetoothTextMessenger
//
//  Created by Cindy Crabtree on 7/20/12.
//  Copyright (c) 2012 Tap Dezign, LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (void)sendMessage:(id)sender;
- (void)connectToDevice:(id)sender;

@end

@implementation ViewController

@synthesize messageReceivedLabel    = _messageReceivedLabel;
@synthesize messageToSendTextField  = _messageToSendTextField;
@synthesize session                 = _session;
@synthesize sendButton              = _sendButton;

- (void)connectToDevice:(id)sender
{
    if (self.session == nil) {
        //create peer picker and show picker of connections
        GKPeerPickerController *peerPicker = [[GKPeerPickerController alloc] init];
        peerPicker.delegate = self;
        peerPicker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
        [peerPicker show];
    }
    
}

- (void)sendMessage:(id)sender 
{   
    //package text field text as NSData object 
    NSData *textData = [self.messageToSendTextField.text dataUsingEncoding:NSASCIIStringEncoding];
    //send data to all connected devices
    [self.session sendDataToAllPeers:textData withDataMode:GKSendDataReliable error:nil];
    
}

#pragma mark - 
#pragma mark - GKPeerPickerControllerDelegate
- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type
{
    //create ID for session
    NSString *sessionIDString = @"MTBluetoothSessionID";
    //create GKSession object
    GKSession *session = [[GKSession alloc] initWithSessionID:sessionIDString displayName:nil sessionMode:GKSessionModePeer];
    return session;
}

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session
{
    //set session delegate and dismiss the picker
    session.delegate = self;
    self.session = session; 
    picker.delegate = nil;
    [picker dismiss];
}

#pragma mark - 
#pragma mark - GKSessionDelegate
- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
    if (state == GKPeerStateConnected){
        [session setDataReceiveHandler:self withContext:nil]; //set ViewController to receive data
        self.sendButton.enabled = YES; //enable send button when session is connected
    }
    else {
        self.sendButton.enabled = NO; //disable send button if session is disconnected
        self.session.delegate = nil; 
        self.session = nil; //allow session to reconnect if it gets disconnected
    }
}

- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context
{   
    //unpackage NSData to NSString and set incoming text as label's text
    NSString *receivedString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    self.messageReceivedLabel.text = receivedString;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Button to connect to other device
    UIButton *connectButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    connectButton.frame = CGRectMake(20.0f, 20.0f, 80.0f, 40.0f);
    [connectButton setTitle:@"Connect" forState:UIControlStateNormal];
    connectButton.tintColor = [UIColor darkGrayColor];
    [connectButton addTarget:self action:@selector(connectToDevice:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:connectButton];
    
    //Button to send message to other device
    UIButton *sendButton_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendButton_.frame = CGRectMake(220.0f, 20.0f, 80.0f, 40.0f);
    [sendButton_ setTitle:@"Send" forState:UIControlStateNormal];
    sendButton_.tintColor = [UIColor darkGrayColor];
    sendButton_.enabled = NO; //set button as disabled until connection is made
    [sendButton_ addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    self.sendButton = sendButton_;
    [self.view addSubview:self.sendButton];
    
    //Label for message that is received
    self.messageReceivedLabel = nil;
	CGRect messageReceivedLabel_Frame = CGRectMake(20.0f, 80.0f, 280.0f, 44.0f);
    UILabel *messageReceivedLabel_ = [[UILabel alloc] initWithFrame:messageReceivedLabel_Frame];
    messageReceivedLabel_.textAlignment = UITextAlignmentCenter;
    messageReceivedLabel_.font = [UIFont boldSystemFontOfSize:20.0f];
    self.messageReceivedLabel = messageReceivedLabel_;
    [self.view addSubview:self.messageReceivedLabel];
    
    //Text field to input message to send
    CGRect messageToSendTextField_Frame = CGRectMake(20.0f, 144.0f, 280.0f, 44.0f);
    UITextField *messageToSendTextField_ = [[UITextField alloc] initWithFrame:messageToSendTextField_Frame];
    messageToSendTextField_.font = [UIFont systemFontOfSize:20.0f];
    messageToSendTextField_.backgroundColor = [UIColor whiteColor];
    messageToSendTextField_.clearButtonMode = UITextFieldViewModeAlways;
    messageToSendTextField_.placeholder = @"Enter a message to send";
    messageToSendTextField_.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.messageToSendTextField = messageToSendTextField_;
    [self.view addSubview:self.messageToSendTextField];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
