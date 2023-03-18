import { Desk } from 'src/desks/entities/desk.entity';
import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Reservation {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  date: Date;

  @ManyToOne(() => Desk, (desk) => desk.reservations)
  desk: Desk;
}
