#import "AppellationTableViewController.h"

#import "Appellation.h"

@interface AppellationTableViewController ()

@end

@implementation AppellationTableViewController

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Appellation *appellation = [[super fetchedResultsController] objectAtIndexPath:indexPath];
    cell.textLabel.text = appellation.name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
}

@end
