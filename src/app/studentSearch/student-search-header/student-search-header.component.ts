import { Component, OnInit } from '@angular/core';
import { Location } from '@angular/common';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'student-search-header',
  templateUrl: './student-search-header.component.html',
  styleUrls: ['./student-search-header.component.css']
})
export class StudentSearchHeaderComponent implements OnInit {

    public headerText: string;

    constructor(private location: Location,
                private route: ActivatedRoute
    ) {}

    ngOnInit() {
        let id = this.route.snapshot.paramMap.get('id');
        this.setHeaderText(id);
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
