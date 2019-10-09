import React from "react";
import styled from "styled-components";
import { ReactComponent as CatSVG } from '../images/cat.svg';

const Cat = ({ color, id, generation, owner, onClick }) => (
  <Card onClick={() => onClick(id)}>
  <CatSVG width="120" height="120" style={{ fill: `${color}`}}/>
    <Description>
      <Name>Kat #{id}</Name>
      <Generation>Generation {generation}</Generation>
      <Owner>Owner {owner}</Owner>
    </Description>
  </Card>
);

const Card = styled.div`
  cursor: pointer;
  padding: 16px;
  margin: 8px;
  width: fit-content;
  border-radius: 5px;
  border: 1px solid rgba(0, 0, 0, 0.05);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
  transition: box-shadow 200ms;

  &:hover {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
  }
`;

const Description = styled.div`
  margin-top: 16px;
  display: flex;
  flex-direction: column;
`;

const Name = styled.span`
  font-weight: bold;
`;

const Owner = styled.span`
  font-weight: bold;
`;

const Generation = styled.span`
  margin-top: 8px;
  color: rgba(0, 0, 0, 0.5);
`;

export default Cat;
