import { Desk } from 'src/desks/entities/desk.entity';
import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Reservation {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  date: string;

  @Column()
  deskId: number;

  @OneToMany(() => Desk, (desk) => desk.reservations)
  desk: Desk;
}
