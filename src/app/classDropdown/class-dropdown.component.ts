import { Component, OnInit } from '@angular/core';

import { Class } from './../models/class';
import { ClassService } from './../services/class/class.service';

@Component({
  selector: 'class-dropdown',
  templateUrl: './class-dropdown.component.html',
  styleUrls: ['./class-dropdown.component.css']
})
export class ClassDropdownComponent implements OnInit {
    classes: Class[] = [];
    selectedClass: Class;

    constructor(private classService: ClassService) { }

    ngOnInit(): void {
        this.classService.getClasses()
            .then(classes => {
                this.classes = classes;
                this.selectedClass = classes[0];
            });
    }

    selectedClassChange(event)
    {
        this.classService.SelectedClass = event;
    }
}
