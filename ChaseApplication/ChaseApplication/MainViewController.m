//
//  MainViewController.m
//  ChaseApplication
//
//  Created by Nikhil Singh on 12/3/16.
//  Copyright © 2016 NikhilSingh. All rights reserved.
//

#import "MainViewController.h"
#import "Downloader.h"
#import "Location.h"
#import "MapAnnotation.h"
#import "MapAnnotationView.h"

@interface MainViewController () <DownloaderDelegate, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate> {
    NSMutableArray *atms;
    NSMutableArray *branches;
    
}

@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (weak, nonatomic) IBOutlet UIView *resultsView;
@property (weak, nonatomic) IBOutlet UITableView *bankTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *atmBranchSegment;
@property (weak, nonatomic) IBOutlet MKMapView *bankMaps;
@property (weak, nonatomic) IBOutlet UIButton *mapListBtn;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    atms = [[NSMutableArray alloc] init];
    branches = [[NSMutableArray alloc] init];
    
}

- (IBAction)getCurrentLocation:(id)sender {
    
}

- (IBAction)togleMap:(id)sender {
    if(self.bankMaps.hidden){
        self.bankMaps.hidden = NO;
        self.bankTableView.hidden = YES;
        [self.mapListBtn setTitle:@"LIST" forState:UIControlStateNormal];
    } else {
        self.bankMaps.hidden = YES;
        self.bankTableView.hidden = NO;
        [self.mapListBtn setTitle:@"MAP" forState:UIControlStateNormal];
    }
}

- (IBAction)switchAtms:(id)sender {
    [self.bankTableView reloadData];
}

- (IBAction)searchClick:(id)sender {
    NSString *searchFieldText = self.locationField.text;
    
    Downloader *downloader = [[Downloader alloc] initWithCustomInput:searchFieldText withDelegate:self];
    [self.locationField resignFirstResponder];
    
}

-(void) displayAnnotationFor:(int)atmOrBranch {
     [self.bankMaps removeAnnotations:self.bankMaps.annotations];
    if(atmOrBranch == 0){
        for (Location *location in atms) {
            MapAnnotation *ann = [[MapAnnotation alloc] init];
            ann.coordinate = CLLocationCoordinate2DMake(location.lat, location.lng);
            ann.title = location.name;
            ann.subtitle = location.address;
            ann.isThisAtm = YES;
            [self.bankMaps addAnnotation:ann];
        }
    } else {
        for (Location *location in branches) {
            MapAnnotation *ann = [[MapAnnotation alloc] init];
            ann.coordinate = CLLocationCoordinate2DMake(location.lat, location.lng);
            ann.title = location.name;
            ann.subtitle = location.address;
            ann.isThisAtm = NO;
            [self.bankMaps addAnnotation:ann];
        }
    }
    
    MapAnnotation *mapItem = [self.bankMaps.annotations firstObject];
    [self.bankMaps setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(mapItem.coordinate.latitude, mapItem.coordinate.longitude), MKCoordinateSpanMake(0.05, 0.05))];
}

#pragma mark - Downloader Delegate

-(void) fetchedLocations:(NSArray *) locationObjects{
    [atms removeAllObjects];
    [branches removeAllObjects];
    [self.resultsView setHidden:NO];
    
    self.atmBranchSegment.selectedSegmentIndex = 0;
    
    
    
    for (Location *location in locationObjects) {
        if(location.isThisAtm){
            [atms addObject:location];
        } else {
            [branches addObject:location];
        }
    }
    [self.bankTableView reloadData];
    [self displayAnnotationFor:0];

}

#pragma mark - TableView Datasource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.atmBranchSegment.selectedSegmentIndex == 0){
        [self displayAnnotationFor:0];
        return atms.count;
    }
    [self displayAnnotationFor:1];
    return branches.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bankCell"];
    Location *location;
    if(self.atmBranchSegment.selectedSegmentIndex == 0){
        location = [atms objectAtIndex:indexPath.row];
    } else {
        location = [branches objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = location.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%0.2f miles)",location.address, location.distance];

    return cell;
    
}

#pragma mark - MapView Delegate

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    MapAnnotationView *view = [[MapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    return view;
}





@end
