import { Component, OnInit, Input } from '@angular/core';
import { Location } from '@angular/common';

@Component({
  selector: 'student-search-header',
  templateUrl: './student-search-header.component.html',
  styleUrls: ['./student-search-header.component.css']
})
export class StudentSearchHeaderComponent implements OnInit {

    @Input('searchType') searchType: string;

    public headerText: string;

    constructor(private location: Location
    ) {}

    ngOnInit() {
        this.setHeaderText(this.searchType);
    }

    public goBack() {
        this.location.back();
    }

    private setHeaderText(id: string) {
        switch (id) {
            case 'new': 
                this.headerText = 'Add New Student';
                break;
            case 'transfer': 
                this.headerText = 'Add Transfer Student';
                break;
            case 'visiting':
                this.headerText = 'Add Visiting Student';
                break;
        }
    }    

}
