Eunice Kim

/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */

SELECT name, membercost 
FROM `Facilities` 
WHERE membercost !=0.0


/* Q2: How many facilities do not charge a fee to members? */

SELECT 
CASE 
WHEN membercost = 0.0 THEN  'Yes'
ELSE  'No'
END AS Free_Facility, 
COUNT( 1 ) AS count
FROM  `Facilities` 
GROUP BY 1

/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SELECT facid, name, membercost, monthlymaintenance, monthlymaintenance 
FROM `Facilities`
WHERE membercost < monthlymaintenance * 0.2


/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */

SELECT *
FROM `Facilities`
WHERE facid in (1,5)

/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

SELECT name, monthlymaintenance, 
CASE WHEN monthlymaintenance > 100.0 THEN 'expensive'
ELSE  'cheap'
END AS "Facility type"
FROM `Facilities`


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SELECT surname, firstname
FROM  `Members` 
WHERE joindate = ( 
	SELECT MAX( joindate ) 
	FROM  `Members` )

/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT DISTINCT concat(mb.firstname, ' ', mb.surname) as membername, fc.name  
FROM `Bookings` AS bk 
INNER JOIN `Facilities` as fc 
ON (bk.facid = fc.facid AND fc.facid in (0, 1)) 
INNER JOIN `Members` AS mb 
ON mb.memid = bk.memid 
WHERE  mb.surname != 'GUEST'
ORDER BY mb.surname


/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SELECT fc.name, concat(mb.firstname, ' ', mb.surname) as membername, 
CASE WHEN mb.memid = 0 THEN fc.guestcost*bk.slots 
ELSE fc.membercost*bk.slots END as cost

FROM `Bookings` AS bk 
INNER JOIN `Facilities` as fc 
ON (bk.facid = fc.facid) 
INNER JOIN `Members` AS mb 
ON mb.memid = bk.memid 
WHERE (bk.starttime LIKE '2012-09-14%') 
HAVING (cost > 30.0) 
ORDER BY cost DESC


/* Q9: This time, produce the same result as in Q8, but using a subquery. */



SELECT f.name, concat(m.firstname, ' ', m.surname) as membername,
	CASE WHEN m.memid = 0 THEN f.guestcost*b.slots 
ELSE f.membercost*b.slots END as cost


FROM 

(SELECT facid, memid, slots FROM `Bookings` WHERE starttime LIKE '2012-09-14%') b
INNER JOIN 
(SELECT memid, surname, firstname FROM `Members`) m
ON b.memid = m.memid


INNER JOIN
(SELECT facid, name, membercost, guestcost FROM `Facilities`) f
ON b.facid = f.facid

HAVING (cost > 30.0) 
ORDER BY cost DESC




/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */


SELECT sub.facility, SUM(sub.cost) AS total_revenue

FROM ( 
SELECT name AS facility,

       CASE WHEN memid = 0 THEN guestcost*slots 
       ELSE membercost*slots END AS cost 

FROM Bookings as b
INNER JOIN Facilities as f 
ON b.facid = f.facid
) sub


GROUP BY sub.facility
HAVING total_revenue < 1000
